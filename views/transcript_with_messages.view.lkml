view: transcript {
  sql_table_name: `looker-private-demo.call_center.transcript_with_messages`
    ;;

  dimension: agent_id {
    type: string
    sql: ${TABLE}.agent_id ;;
  }

  dimension: client_id {
    type: number
    sql: ${TABLE}.client_id ;;
  }

  dimension: conversation_id {
    type: string
    sql: ${TABLE}.conversation_id ;;
  }

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

  dimension: messages {
    hidden: yes
    sql: ${TABLE}.messages ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

view: transcript_with_messages__messages {
  dimension: answer_end {
    type: number
    sql: ${TABLE}.answer_end ;;
  }

  dimension: answer_start {
    type: number
    sql: ${TABLE}.answer_start ;;
  }

  dimension: intent_id {
    type: string
    sql: ${TABLE}.intent_id ;;
  }

  dimension: issue_subtopic {
    type: string
    sql: ${TABLE}.issue_subtopic ;;
  }

  dimension: issue_topic {
    type: string
    sql: ${TABLE}.issue_topic ;;
  }

  dimension: response {
    type: string
    sql: ${TABLE}.response ;;
  }

  dimension: sentiment {
    type: number
    sql: ${TABLE}.sentiment ;;
  }

  dimension: user_end {
    type: number
    sql: ${TABLE}.user_end ;;
  }

  dimension: user_question {
    type: string
    sql: ${TABLE}.user_question ;;
  }

  dimension: user_start {
    type: number
    sql: ${TABLE}.user_start ;;
  }
}
