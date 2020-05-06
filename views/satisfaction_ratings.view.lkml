view: satisfaction_ratings {
  sql_table_name: `looker-private-demo.zendesk.satisfaction_ratings` ;;
  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: comment {
    type: string
    sql: ${TABLE}.comment ;;
  }

  dimension: score {
    type: string
    sql: ${TABLE}.score ;;
  }

  dimension: conversation_id {
    type: string
    sql: ${TABLE}.ticket_id ;;
  }

  measure: count {
    type: count
    label: "Number of Satisfaction Surveys Completed"
    drill_fields: [id]
  }

  measure: percent_conversations_with_survey {
    description: "What percent of conversations completed a satisfaction score?"
    type: number
    sql: ${count}/nullif(${transcript.count},0) ;;
    drill_fields: [id]
  }
}
