
view: conversation_facts {
  view_label: "Conversation"
  derived_table: {
    explore_source: transcript {
      column: conversation_length { field: transcript__messages.total_call_time }
      column: number_of_topics { field: transcript__messages.number_of_topics }
      column: number_of_categories { field: transcript__messages.number_of_categories }
      column: conversation_id {}
      filters: {
        field: transcript__messages.total_call_time
        value: ">0"
      }
      bind_all_filters: yes
    }
  }

  dimension: number_of_topics {
    type: number
  }

  dimension: number_of_categories {
    type: number
  }

  dimension: conversation_id {
    primary_key: yes
    hidden: yes
    label: "Conversation Conversation ID"
  }

  measure: average_number_of_topics {
    type: average
    sql: ${number_of_topics} ;;
    value_format_name: decimal_2
  }

  measure: average_number_of_categories {
    type: average
    sql: ${number_of_categories} ;;
    value_format_name: decimal_2
  }
}
