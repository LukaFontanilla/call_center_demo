view: transcript {
  view_label: "Conversation"
  sql_table_name: `looker-private-demo.call_center.transcript_with_messages`;;

  ### Primar Key ###

  dimension: conversation_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.conversation_id ;;
    link: {
      label: "Listen to entire conversation"
      url: "https://console.cloud.google.com/"
      icon_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/Google-Cloud-Storage-Logo.svg/1200px-Google-Cloud-Storage-Logo.svg.png"
    }
  }

  ### Foreign Keys ###

  dimension: agent_id {
    hidden: yes
    type: string
    sql: ${TABLE}.agent_id ;;
  }

  dimension: client_id {
    hidden: yes
    type: number
    sql: ${TABLE}.client_id ;;
  }

  ### Date Times ###

  dimension_group: conversation_start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.conversation_start_at ;;
  }

  dimension_group: conversation_end {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.conversation_end_at ;;
  }

  ### Database Fields ###

  dimension: messages {
    hidden: yes
    sql: ${TABLE}.messages ;;
  }

  ### Derived Dimensions ###

  dimension: number_of_messages {
    type: number
    sql: array_length(${messages}) ;;
  }

  dimension: conversation_duration {
    type: duration_second
    sql_start: ${conversation_start_raw} ;;
    sql_end: ${conversation_end_raw} ;;
  }

  dimension: passed_to_live_agent {
    description: "Did the conversation involve a Live Agent?"
    type: yesno
    sql: ${agent_id} is not null ;;
  }

  dimension: hung_up_before_call {
    type: yesno
    sql: ${number_of_messages} < 1 ;;
  }

  ### Measures ###

  measure: count {
    type: count
    label: "Number of Conversations"
  }

  measure: count_not_passed_to_live {
    hidden: yes
    label: "Number of Conversations w/o Live Agent"
    type: count
    filters: [passed_to_live_agent: "no"]
  }

  measure: percent_not_passed_to_live {
    group_label: "Percents"
    label: "Percent of Conversations w/o Live Agent"
    type: number
    sql: ${count_not_passed_to_live}/nullif(${count},0) ;;
    value_format_name: percent_1
  }

  measure: average_number_of_messages {
    type: average
    sql: ${number_of_messages} ;;
    value_format_name: decimal_1
  }

  measure: average_calls_per_agent {
    label: "Average Number of Conversations per Agent"
    type: number
    sql: ${count}/nullif(${agents.count},0) ;;
    value_format_name: decimal_1
  }

  measure: average_conversation_duration {
    type: average
    sql: ${conversation_duration}  ;;
    value_format_name: decimal_1
  }

}

view: transcript__messages {
  view_label: "Messages"

  ## Primary key ###

  dimension: message_id {
    primary_key: yes
    sql: ${TABLE}.message_id ;;
  }

  ### Date Times ###

  dimension_group: user_start {
    timeframes: [time, raw]
    group_label: "Timestamps"
    description: "The time that the user began speaking"
    type: time
    sql: timestamp_add(${transcript.conversation_start_raw}, interval cast(${TABLE}.user_start as int64) SECOND) ;;
  }

  dimension_group: user_end {
    timeframes: [time, raw]
    group_label: "Timestamps"
    description: "The time that the user began speaking"
    type: time
    sql: timestamp_add(${user_start_raw}, interval cast(${TABLE}.user_end as int64) SECOND) ;;
  }

  dimension_group: agent_start {
    timeframes: [time, raw]
    group_label: "Timestamps"
    description: "The time that the agent (real or virtual) began speaking"
    type: time
    sql: timestamp_add(${user_end_raw}, interval cast(${TABLE}.answer_start as int64) SECOND) ;;
  }

  dimension_group: agent_end {
    timeframes: [time, raw]
    group_label: "Timestamps"
    description: "The time that the user agent (real or virtual) stopped speaking"
    type: time
    sql: timestamp_add(${agent_start_raw}, interval cast(${TABLE}.answer_end as int64) SECOND) ;;
  }

  ### Durations ###

  dimension: user_duration {
    group_label: "Durations"
    type: duration_second
    description: "The number of seconds that the user was speaking"
    sql_start: ${user_start_raw} ;;
    sql_end: ${user_end_raw} ;;
  }

  dimension: agent_duration {
    group_label: "Durations"
    type: duration_second
    description: "The number of seconds that the agent (real or virtual) was speaking"
    sql_start: ${agent_start_raw} ;;
    sql_end: ${agent_end_raw} ;;
  }

  dimension: seconds_to_answer {
    type: duration_second
    group_label: "Durations"
    description: "The amount of seconds it took for the agent to answer"
    sql_start: ${user_end_raw} ;;
    sql_end: ${agent_start_raw} ;;
  }

  dimension: start_to_end_duration {
    type: duration_second
    group_label: "Durations"
    description: "The amount of seconds from when the customer began speaking to when the agent stopped answering"
    sql_start: ${user_start_raw} ;;
    sql_end: ${agent_end_raw} ;;
  }

  dimension: wait_time_tier {
    type: tier
    style: integer
    sql: ${TABLE}.answer_start  ;;
    tiers: [30,60,120,300,600]
  }

  ### Other Dimensions ###

  dimension: intent_id {
    group_label: "Intent"
    type: string
    sql: ${TABLE}.intent_id ;;
  }

  dimension: issue_subtopic {
    group_label: "Intent"
    label: "Topic"
    type: string
    sql: ${TABLE}.issue_subtopic ;;
  }

  dimension: issue_topic {
    group_label: "Intent"
    label: "Category"
    type: string
    sql: ${TABLE}.issue_topic ;;
  }

  dimension: response_text {
    group_label: "Message Transcript"
    type: string
    sql: ${TABLE}.response ;;
  }

  dimension: question_text {
    group_label: "Message Transcript"
    type: string
    sql: ${TABLE}.user_question ;;
  }

  dimension: message_sentiment {
    label: "Sentiment Score"
    description: "Inferred sentiment score, out of 100%"
    type: number
    sql: case when ${TABLE}.answer_start > 300 and ${TABLE}.sentiment >.2  then ${TABLE}.sentiment-.2
              when ${TABLE}.answer_start > 60 and  ${TABLE}.sentiment <.8 then ${TABLE}.sentiment+.2
              else ${TABLE}.sentiment end;;
    value_format_name: percent_1
  }

  dimension: message_sentiment_category {
    type: string
    sql: case when ${message_sentiment} < .2 then 'Very Negative' when ${message_sentiment} < .4 then 'Negative'
    when ${message_sentiment} < .6 then 'Neutal' when ${message_sentiment} < .8 then 'Positive'
    else 'Very Positive' end;;
  }

  dimension: live_agent {
    type: yesno
    sql: ${TABLE}.live_agent_speaking ;;
  }

  ### Measures ###

  measure: average_sentiment {
    type: average
    sql: ${message_sentiment}  ;;
    value_format_name: percent_1
  }

  measure: number_of_topics {
    hidden: yes
    type: count_distinct
    sql: ${issue_subtopic} ;;
  }

  measure: number_of_categories {
    hidden: yes
    type: count_distinct
    sql: ${issue_topic} ;;
  }

  measure: number_of_messages {
    type: count
  }

  measure: number_of_messages_without_live_agent {
    hidden: yes
    type: count
    filters: [live_agent: "no"]
  }

  measure: percent_of_messages_without_live_agent {
    type: number
    sql: ${number_of_messages_without_live_agent}/nullif(${number_of_messages},0);;
    value_format_name: percent_1
  }

  measure: percent_of_messages_with_live_agent {
    type: number
    sql: 1-(${number_of_messages_without_live_agent}/nullif(${number_of_messages},0));;
    value_format_name: percent_1
  }

  measure: total_time_without_agent {
    hidden: yes
    description: "The total number of seconds for messages without live agents"
    type: sum
    sql: ${start_to_end_duration};;
    filters: [live_agent: "no"]
  }

  measure: total_call_time {
    description: "The amount of time on calls in hours"
    type: sum
    sql: ${start_to_end_duration} ;;
  }

  measure: total_call_time_without_live_agent {
    description: "The amount of time on calls in minutes"
    type: sum
    sql: ${start_to_end_duration} ;;
    filters: [live_agent: "no"]
  }

  measure: percent_call_time_without_live_agent {
    type: number
    description: "The percentage of time on call without live agents"
    sql: 1.0*${total_call_time_without_live_agent}/nullif(${total_call_time},0);;
    value_format_name: percent_1
  }

  measure: approximate_cost_savings {
    type: number
    sql: (${total_time_without_agent}/(60*60)) * {% parameter cost_per_hour %}  ;;
    value_format_name: usd
  }

  measure: average_sentiment_category {
    type: string
    sql: case when ${average_sentiment} < .2 then 'Very Negative' when ${average_sentiment} < .4 then 'Negative'
        when ${average_sentiment} < .6 then 'Neutal' when ${average_sentiment} < .8 then 'Positive'
       else 'Very Positive' end;;
  }

  measure: average_wait_time {
    type: average
    sql: ${seconds_to_answer}  ;;
    value_format_name: decimal_1
  }

  parameter: cost_per_hour {
    description: "The average cost of a live agent, per hour"
    type: number
    default_value: "15"
  }


}
