- dashboard: agent_performance
  title: Agent Performance
  layout: newspaper
  elements:
  - title: Number of Conversations
    name: Number of Conversations
    model: call_center
    explore: transcript
    type: single_value
    fields: [transcript.count, transcript.conversation_start_week]
    fill_fields: [transcript.conversation_start_week]
    filters:
      transcript.conversation_start_week: 2 weeks ago for 2 weeks
    sorts: [transcript.conversation_start_week desc]
    limit: 500
    dynamic_fields: [{table_calculation: difference_in_calls, label: 'Difference in
          # Calls', expression: "${transcript.count}-offset(${transcript.count},1)",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: Prior Week
    defaults_version: 1
    hidden_fields: [transcript.conversation_start_week]
    listen:
      Agent: agents.name
    row: 0
    col: 3
    width: 5
    height: 4
  - title: Average Call Duration
    name: Average Call Duration
    model: call_center
    explore: transcript
    type: single_value
    fields: [transcript.average_conversation_duration]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: duration_in_minutes, label: Duration in Minutes,
        expression: "${transcript.average_conversation_duration}/60", value_format: !!null '',
        value_format_name: decimal_1, _kind_hint: measure, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: Percent without Live Agent
    defaults_version: 1
    hidden_fields: [transcript.average_conversation_duration]
    listen:
      Agent: agents.name
    row: 0
    col: 8
    width: 5
    height: 4
  - title: High Value Clients
    name: High Value Clients
    model: call_center
    explore: transcript
    type: single_value
    fields: [client.number_of_clients]
    filters:
      transcript.count: ">0"
      transcript.conversation_start_date: 1 weeks ago for 1 weeks
      banking_client_facts.balance_yesterday: ">5000"
    limit: 15
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: transcript.count, id: transcript.count,
            name: Number of Conversations}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}, {label: !!null '',
        orientation: right, series: [{axisId: banking_client_facts.total_in_accounts_yesterday,
            id: banking_client_facts.total_in_accounts_yesterday, name: Total In Accounts
              Yesterday}], showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    series_colors:
      banking_client_facts.total_in_accounts_yesterday: "#72D16D"
      transcript.count: "#FFD95F"
    defaults_version: 1
    series_types: {}
    listen:
      Agent: agents.name
    row: 4
    col: 8
    width: 5
    height: 4
  - title: Number of Conversations by Category
    name: Number of Conversations by Category
    model: call_center
    explore: transcript
    type: looker_area
    fields: [transcript__messages.number_of_messages, transcript__messages.issue_topic,
      transcript.conversation_start_week]
    pivots: [transcript__messages.issue_topic]
    fill_fields: [transcript.conversation_start_week]
    filters:
      transcript__messages.issue_topic: "-NULL"
      transcript.conversation_start_week: 52 weeks ago for 52 weeks
    sorts: [transcript__messages.number_of_messages desc 0, transcript__messages.issue_topic]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: transcript__messages.number_of_messages,
            id: transcript__messages.number_of_messages, name: Number of Messages}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    series_types: {}
    series_colors:
      Yes - transcript__messages.number_of_messages: "#E57947"
      Credit Card - transcript__messages.number_of_messages: "#3EB0D5"
      Change Personal Information - transcript__messages.number_of_messages: "#4276BE"
      Online Banking - transcript__messages.number_of_messages: "#75E2E2"
      Open a New Account - transcript__messages.number_of_messages: "#C2DD67"
      Speak with an Advisor - transcript__messages.number_of_messages: "#72D16D"
      Submit a Fraud Alert - transcript__messages.number_of_messages: "#FBB555"
    series_labels:
      Yes - transcript__messages.number_of_messages: From Live Agent
      No - transcript__messages.number_of_messages: From Virtual Agent
    ordering: none
    show_null_labels: false
    defaults_version: 1
    listen:
      Agent: agents.name
    row: 8
    col: 0
    width: 24
    height: 7
  - title: Average Sentiment
    name: Average Sentiment
    model: call_center
    explore: transcript
    type: single_value
    fields: [transcript__messages.average_sentiment, transcript__messages.average_sentiment_category]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: Sentiment
    defaults_version: 1
    listen:
      Agent: agents.name
    row: 4
    col: 3
    width: 5
    height: 4
  - title: Customer Ratings
    name: Customer Ratings
    model: call_center
    explore: transcript
    type: looker_grid
    fields: [satisfaction_ratings.conversation_id, satisfaction_ratings.comment, satisfaction_ratings.score,
      transcript.conversation_start_date]
    sorts: [transcript.conversation_start_date desc]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    listen:
      Agent: agents.name
    row: 15
    col: 0
    width: 12
    height: 10
  - title: Conversation Duration by Category
    name: Conversation Duration by Category
    model: call_center
    explore: transcript
    type: looker_column
    fields: [transcript.average_conversation_duration, transcript__messages.issue_topic,
      transcript.conversation_start_month]
    pivots: [transcript__messages.issue_topic]
    fill_fields: [transcript.conversation_start_month]
    filters:
      transcript.conversation_start_week: 1 years
    sorts: [transcript__messages.issue_topic]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    series_colors:
      Change Personal Information - transcript.average_conversation_duration: "#4276BE"
      Credit Card - transcript.average_conversation_duration: "#FBB555"
      Open a New Account - transcript.average_conversation_duration: "#592EC2"
      Speak with an Advisor - transcript.average_conversation_duration: "#3EB0D5"
      Submit a Fraud Alert - transcript.average_conversation_duration: "#FFD95F"
    defaults_version: 1
    listen:
      Agent: agents.name
    row: 15
    col: 12
    width: 12
    height: 10
  - title: Agent vs Client Speaking
    name: Agent vs Client Speaking
    model: call_center
    explore: transcript
    type: looker_donut_multiples
    fields: [transcript__messages.total_seconds_agent_speaking, transcript__messages.total_seconds_client_speaking]
    limit: 500
    column_limit: 50
    show_value_labels: false
    font_size: 12
    series_colors:
      transcript__messages.total_seconds_agent_speaking: "#4276BE"
      transcript__messages.total_seconds_client_speaking: "#FBB555"
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    value_labels: legend
    label_type: labPer
    row: 0
    col: 13
    width: 7
    height: 8
  filters:
  - name: Agent
    title: Agent
    type: field_filter
    default_value: Tonya Koop
    allow_multiple_values: true
    required: false
    model: call_center
    explore: transcript
    listens_to_filters: []
    field: agents.name
