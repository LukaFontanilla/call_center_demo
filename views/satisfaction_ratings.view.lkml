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

  dimension: conversation_id {
    type: string
    hidden: yes
    sql: ${TABLE}.ticket_id ;;
  }

  dimension: score_sort {
    hidden: yes
    type: string
    sql: case when ${TABLE}.SCORE = 'Very unsatisfied' then 1
              when ${TABLE}.SCORE = 'Unsatisfied' then 2
              when ${TABLE}.SCORE = 'Neutral' then 3
              when ${TABLE}.SCORE = 'Satisfied' then 4
              when ${TABLE}.SCORE = 'Very satisfied' then 5 else null end
              ;;
  }

  dimension: score {
    group_label: "Rating"
    label: "Customer Satisfaction Rating"
    order_by_field: score_sort
    type: string
    sql: ${TABLE}.SCORE;;
    html:
    {% if value == 'Very unsatisfied' %}
    <div style="background: #FBB555; border-radius: 2px; color: #fff; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;">{{ rendered_value }}</div>
    {% elsif value == 'Unsatisfied' %}
        <div style="background: #FBB555; border-radius: 2px; color: #fff; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;">{{ rendered_value }}</div>
    {% elsif value == 'Neutral' %}
    <div style="background: #c9daf2; border-radius: 2px; color: #fff; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;">{{ rendered_value }}</div>
    {% elsif value == 'Satisfied' %}
    <div style="background: #8BC34A; border-radius: 2px; color: #fff; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;">{{ rendered_value }}</div>
    {% elsif value == 'Very satisfied' %}
    <div style="background:  #8BC34A; border-radius: 2px; color: #fff; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;">{{ rendered_value }}</div>
    {% endif %} ;;
  }

  measure: average_csat {
    label: "Average CSAT"
    description: "The average customer satisfaction score, on a scale of 1-5 with 1 being Very Unsatisfied"
    type: average
    sql: ${score_sort} ;;
    value_format_name: decimal_1
  }

  measure: count {
    label: "Number of Satisfaction Ratings"
    type: count
    drill_fields: [id, groups.id, groups.name, ticket.id]
  }

  measure: percent_conversations_with_survey {
    description: "What percent of conversations completed a satisfaction score?"
    type: number
    sql: ${count}/nullif(${transcript.count},0) ;;
    drill_fields: [id]
    value_format_name: percent_1
  }
}
