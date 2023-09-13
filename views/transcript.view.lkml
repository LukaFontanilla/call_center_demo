view: transcript {
  view_label: "Conversation"
  sql_table_name: `looker-private-demo.call_center.transcript_with_messages`;;
  drill_fields: [conversation_short,conversation_start_date,passed_to_live_agent,banking_client_facts.account_id, transcript__messages.number_of_messages,
    conversation_duration,transcript__messages.average_sentiment_category]

  ### Primar Key ###

  dimension: conversation_id {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.conversation_id ;;
  }

  dimension: conversation_short {
    label: "Conversation ID"
    sql: substr(${conversation_id},0,5) ;;
    link: {
      label: "Listen to entire conversation"
      url: "https://console.cloud.google.com/"
      icon_url: "https://coralogix.com/wp-content/uploads/2020/01/google-cloud-storage.png"
    }
    link: {
      label: "View full transcript"
      url: "https://console.cloud.google.com/"
      icon_url: "https://coralogix.com/wp-content/uploads/2020/01/google-cloud-storage.png"
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
      year,
      day_of_week,
      hour_of_day
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

  dimension: months_since_signup {
    description: "The months between the conversation start date and the day the client's account was created"
    type: duration_month
    sql_start: ${banking_client_facts.account_start_raw} ;;
    sql_end: ${conversation_start_raw};;
  }


  dimension: months_since_first_conversation {
    description: "The months between the conversation start date and the client's first conversation"
    type:duration_month
    sql_start: ${client_call_facts.first_conversation_raw};;
    sql_end: ${conversation_start_raw};;
  }

  dimension: is_first_call {
    description: "Is this the users first call?"
    type: yesno
    sql: ${conversation_start_raw} > ${client_call_facts.first_conversation_raw};;
  }

  ### Database Fields ###

  dimension: messages {
    hidden: yes
    sql:
    -- spectacles: ignore
    ${TABLE}.messages ;;
  }

  ### Derived Dimensions ###

  dimension: number_of_messages {
    type: number
    sql: array_length(${messages}) ;;
  }

  dimension: conversation_duration {
    label: "Conversation Duration (minutes)"
    type: duration_minute
    sql_start: ${conversation_start_raw} ;;
    sql_end: ${conversation_end_raw} ;;
  }

  dimension: passed_to_live_agent {
    description: "Did the conversation involve a Live Agent?"
    type: yesno
    sql: ${agent_id} is not null ;;
  }

  dimension: drop_off {
    type: yesno
    sql: ${number_of_messages} < 1 ;;
  }

  dimension: resolved_on_call {
    description: "Was the issue resolved on the call or did it require a followup?"
    type: yesno
    sql: ${TABLE}.resolved_on_call = 'Yes' ;;
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
    label: "Percent of Conversations w/o Live Agent"
    type: number
    sql: ${count_not_passed_to_live}/nullif(${count},0) ;;
    value_format_name: percent_1
  }

  measure: average_number_of_messages {
    label: "Avergae Number of Messages per Call"
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
    label: "Average Conversation Duration (min)"
    type: average
    sql: ${conversation_duration}  ;;
    value_format_name: decimal_1
  }

  measure: first_conversation_time {
    hidden: yes
    type: date_time
    sql: min(${conversation_start_raw}) ;;
  }

}

view: transcript__messages {
  view_label: "Messages"
  drill_fields: [transcript.conversation_short, message_id, issue_subtopic, issue_topic, message_sentiment, message_sentiment_category]

  ## Primary key ###

  dimension: message_id {
    primary_key: yes
    sql: ${TABLE}.message_id ;;
    drill_fields: [question_text]
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
    hidden: yes
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

  dimension: wait_time {
    description: "The total time waiting for a live agent in seconds"
    group_label: "Durations"
    type: number
    sql:${TABLE}.answer_start;;
#     sql: case when ${transcript.passed_to_live_agent} then (
#               case when ${issue_topic} in ('Submit a Fraud','Speak with an Advisor') then ${TABLE}.answer_start*6
#                     when  ${issue_topic} = 'Open a New Account' then ${TABLE}.answer_start*5
#               else ${TABLE}.answer_start end) else null end ;;
  }

  dimension: wait_time_tier {
    group_label: "Durations"
    description: "Wait time for 30, 60, 120, 300, 600 second buckets"
    type: tier
    style: integer
    sql: ${wait_time} ;;
    tiers: [30,60,120,300,600]
  }

  ### Other Dimensions ###

  dimension: intent_id {
    group_label: "Intent"
    type: string
    sql: ${TABLE}.intent_id ;;
    link: {
      label: "View Intent in DialogFlow Console"
      url: "https://dialogflow.cloud.google.com/#"
      icon_url: "https://cdn.clipart.email/b8a0fc38769b62b1328d4fa6ce96ed84_orange-background-png-download-512512-free-transparent-_900-520.jpeg"
    }
  }

  dimension: issue_subtopic {
    drill_fields: [intent_id]
    group_label: "Intent"
    label: "Topic"
    type: string
    sql: ${TABLE}.issue_subtopic ;;
    link: {
      label: "View Intent in DialogFlow Console"
      url: "https://dialogflow.cloud.google.com/#"
      icon_url: "https://www.pngitem.com/pimgs/m/432-4328680_crime-dashboard-navigation-icon-emblem-hd-png-download.png"
    }
  }

  dimension: issue_topic {
    drill_fields: [issue_subtopic]
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

  parameter: number_words_gram {
    label: "Number of Words in the Gram"
    type: number
    view_label: "N - Grams"
    description: "The number of words for the N gram analysis (e.g. 2 means use bi-grams)"
  }

  dimension: question_text {
    group_label: "Message Transcript"
    type: string
    sql: ${TABLE}.user_question ;;
  }

  measure: question_gram {
    hidden: yes
    view_label: "N - Grams"
    #type: string
    sql:  ARRAY_CONCAT_AGG(ML.NGRAMS(REGEXP_EXTRACT_ALL(LOWER(${question_text}), '[a-z]+'),[{% parameter number_words_gram %},{% parameter number_words_gram %}]))  ;;
  }

  dimension: message_sentiment {
    label: "Sentiment Score"
    description: "Inferred sentiment score, out of 100%"
    type: number
    sql: case when ${TABLE}.answer_start > 300 and ${TABLE}.sentiment >.25  then ${TABLE}.sentiment-.25
              when ${TABLE}.answer_start > 60 and  ${TABLE}.sentiment <.75 then ${TABLE}.sentiment+.25
              else (case when ${TABLE}.sentiment < .9 then  ${TABLE}.sentiment + .1 else ${TABLE}.sentiment end) end;;
    value_format_name: percent_1
  }

  dimension: message_sentiment_category {
    type: string
    sql: case when ${message_sentiment} < .2 then 'Very Negative' when ${message_sentiment} < .4 then 'Negative'
    when ${message_sentiment} < .6 then 'Neutral' when ${message_sentiment} < .8 then 'Positive'
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
    drill_fields: []
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
    drill_fields: [question_text,response_text,user_start_time,user_end_time,agent_start_time,agent_end_time]
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
        when ${average_sentiment} < .6 then 'Neutral' when ${average_sentiment} < .8 then 'Positive'
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

  measure: total_seconds_agent_speaking {
    type: sum
    sql: ${user_duration} ;;
  }

  measure: total_seconds_client_speaking {
    type: sum
    sql: ${agent_duration};;
  }


}
