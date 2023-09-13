view: agents {
  sql_table_name: `looker-private-demo.zendesk.users`;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: active {
    type: yesno
    sql: ${TABLE}.active ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    link: {
      label: "Agent Performance"
      url: "/dashboards/5kxrH6SEfcxWdZi1Gts3La?Agent={{ value | encode_uri }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
    action: {
      label: "Send message to {{ name }}"
      url: "https://desolate-refuge-53336.herokuapp.com/posts"
      icon_url: "https://sendgrid.com/favicon.ico"
      param: {
        name: "some_auth_code"
        value: "abc123456"
      }
      param: {
        name: "Agent Email"
        value: "{{ email._value }}"
        ##this is a parameter that you pass behind the scenes
      }
      form_param: {
        name: "Subject"
        required: yes
        default: "Great job {{ name }}!"
      }
      form_param: {
        name: "Body"
        type: textarea
        required: yes
        default:
        "I've been reviewing your calls recently and you're doing a great job, keep up the good work"
      }
    }
    required_fields: [email]
  }

  dimension: organization_id {
    hidden: yes
    type: string
    sql: ${TABLE}.organization_id ;;
  }

  dimension: role {
    type: string
    sql: ${TABLE}.role ;;
  }

  dimension: time_zone {
    type: string
    sql: ${TABLE}.time_zone ;;
  }

  dimension_group: hire {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.timestamp ;;
  }

  measure: count {
    type: count
    label: "Number of Agents"
    drill_fields: [id, name]
  }

}
