
view: ngrams {
  view_label: "N - Grams"
  derived_table: {
    explore_source: transcript {
      column: question_gram { field: transcript__messages.question_gram }
      column: message_id { field: transcript__messages.message_id }
      bind_all_filters: yes
    }
  }

  dimension: message_id {
    hidden: yes
  }

  dimension: question_gram {
    hidden: yes
  }
}


view: ngrams__question_gram {
  view_label: "N - Grams"
  dimension: question_gram {
    type: string
    sql: ${TABLE};;
  }

  dimension: primary_key {
    hidden: yes
    type: string
    primary_key: yes
    sql: concat(${question_gram},${ngrams.message_id}) ;;
  }

  measure: count {
    type: number
    sql: APPROX_COUNT_DISTINCT(${primary_key}) ;;
  }

}
