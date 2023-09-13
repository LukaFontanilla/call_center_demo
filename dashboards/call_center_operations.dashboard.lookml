- dashboard: call_center_operations
  title: Call Center Operations
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "data from call center AI"
  preferred_slug: OQXcicrOxOpC8QzLSirxZS
  elements:
  - title: Number of Calls
    name: Number of Calls
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
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: Prior Week
    defaults_version: 1
    hidden_fields: [transcript.conversation_start_week]
    listen: {}
    row: 2
    col: 3
    width: 6
    height: 4
  - title: "% Calls Handled Without Live Agent"
    name: "% Calls Handled Without Live Agent"
    model: call_center
    explore: transcript
    type: single_value
    fields: [transcript.conversation_start_week, transcript.percent_not_passed_to_live,
      goal]
    filters:
      transcript.conversation_start_week: 1 weeks ago for 1 weeks
    sorts: [transcript.conversation_start_week desc]
    limit: 500
    dynamic_fields: [{dimension: goal, label: Goal, expression: 75/100, value_format: !!null '',
        value_format_name: percent_0, _kind_hint: dimension, _type_hint: number}]
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: Goal
    conditional_formatting: [{type: less than, value: 0.75, background_color: '',
        font_color: "#E57947", color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: 85de97da-2ded-4dec-9dbd-e6a7d36d5825}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    defaults_version: 1
    hidden_fields: [transcript.conversation_start_week]
    listen: {}
    row: 2
    col: 9
    width: 6
    height: 4
  - name: Overall KPIs
    type: text
    title_text: Overall KPIs
    subtitle_text: Performance Indicators for the Last Complete Week
    row: 0
    col: 0
    width: 24
    height: 2
  - name: Customer & Topic Overview
    type: text
    title_text: Customer & Topic Overview
    subtitle_text: How can we reduce the number of support calls needed?
    body_text: ''
    row: 10
    col: 0
    width: 24
    height: 2
  - name: Agent Performance
    type: text
    title_text: Agent Performance
    subtitle_text: Where do we need to improve our agents?
    body_text: ''
    row: 53
    col: 0
    width: 24
    height: 2
  - title: Avg Call Duration (min)
    name: Avg Call Duration (min)
    model: call_center
    explore: transcript
    type: single_value
    fields: [transcript.average_conversation_duration, transcript.conversation_start_week]
    fill_fields: [transcript.conversation_start_week]
    filters:
      transcript.conversation_start_week: 2 weeks ago for 2 weeks
    sorts: [transcript.conversation_start_week desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: duration_in_minutes, label: Duration in Minutes,
        expression: "${transcript.average_conversation_duration}/60", value_format: !!null '',
        value_format_name: decimal_1, _kind_hint: measure, _type_hint: number}, {
        table_calculation: percent_change, label: Percent Change, expression: "(${transcript.average_conversation_duration}\
          \ - offset(${transcript.average_conversation_duration}, 1)) / ${transcript.average_conversation_duration}",
        value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: Prior
    defaults_version: 1
    hidden_fields: [transcript.average_conversation_duration]
    listen: {}
    row: 2
    col: 15
    width: 6
    height: 4
  - title: Cost Savings Last Week
    name: Cost Savings Last Week
    model: call_center
    explore: transcript
    type: single_value
    fields: [transcript__messages.approximate_cost_savings, transcript__messages.percent_call_time_without_live_agent]
    filters:
      transcript.conversation_start_date: 1 weeks ago for 1 weeks
      transcript__messages.cost_per_hour: '15'
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
    comparison_label: Total Call time w/o Live
    defaults_version: 1
    listen: {}
    row: 6
    col: 9
    width: 6
    height: 4
  - title: Average Sentiment Score
    name: Average Sentiment Score
    model: call_center
    explore: transcript
    type: single_value
    fields: [transcript__messages.average_sentiment, transcript__messages.average_sentiment_category]
    filters:
      transcript.conversation_start_date: 2 weeks ago for 2 weeks
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: Sentiment
    conditional_formatting: [{type: less than, value: 0.7, background_color: '', font_color: "#E57947",
        color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7, palette_id: 85de97da-2ded-4dec-9dbd-e6a7d36d5825},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    defaults_version: 1
    listen: {}
    row: 6
    col: 15
    width: 6
    height: 4
  - title: Topics That Virtual Agents Solve Well
    name: Topics That Virtual Agents Solve Well
    model: call_center
    explore: transcript
    type: looker_bar
    fields: [transcript__messages.issue_subtopic, transcript__messages.percent_of_messages_without_live_agent,
      transcript__messages.total_call_time]
    filters:
      transcript__messages.issue_topic: "-NULL"
    sorts: [transcript__messages.percent_of_messages_without_live_agent]
    limit: 15
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
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: !!null '', orientation: top, series: [{axisId: transcript__messages.total_call_time,
            id: transcript__messages.total_call_time, name: Total Call Time}], showLabels: true,
        showValues: true, minValue: 0.75, valueFormat: '0,,"M"', unpinAxis: true,
        tickDensity: custom, type: linear}, {label: Messages w/o Live Agent, orientation: bottom,
        series: [{axisId: transcript__messages.percent_of_messages_without_live_agent,
            id: transcript__messages.percent_of_messages_without_live_agent, name: Percent
              of Messages Without Live Agent}], showLabels: true, showValues: true,
        minValue: 0.75, unpinAxis: true, tickDensity: default, type: linear}]
    size_by_field: transcript__messages.total_call_time
    series_types: {}
    series_colors:
      Yes - transcript__messages.number_of_messages: "#E57947"
      conversation_topic_facts.average_conversation_length: "#FBB555"
      transcript__messages.percent_of_messages_without_live_agent: "#3EB0D5"
      transcript__messages.total_call_time: "#75E2E2"
    series_labels:
      Yes - transcript__messages.number_of_messages: From Live Agent
      No - transcript__messages.number_of_messages: From Virtual Agent
    defaults_version: 1
    listen: {}
    row: 28
    col: 0
    width: 12
    height: 9
  - title: Areas Where Clients Are Happier with Live Agent
    name: Areas Where Clients Are Happier with Live Agent
    model: call_center
    explore: transcript
    type: looker_bar
    fields: [transcript__messages.issue_topic, transcript__messages.average_sentiment,
      transcript__messages.live_agent]
    pivots: [transcript__messages.live_agent]
    fill_fields: [transcript__messages.live_agent]
    sorts: [transcript__messages.live_agent 0, transcript__messages.issue_topic desc]
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
    color_application:
      collection_id: d754397b-2c05-4470-bbbb-05eb4c2b15cd
      palette_id: b0768e0d-03b8-4c12-9e30-9ada6affc357
      options:
        steps: 5
    y_axes: [{label: '', orientation: bottom, series: [{axisId: transcript__messages.average_sentiment,
            id: No - transcript__messages.average_sentiment, name: Virtual Agent},
          {axisId: transcript__messages.average_sentiment, id: Yes - transcript__messages.average_sentiment,
            name: Live Agent}], showLabels: false, showValues: true, minValue: 0.45,
        valueFormat: '', unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    series_types: {}
    series_colors: {}
    series_labels:
      Yes - transcript__messages.average_sentiment: Live Agent
      No - transcript__messages.average_sentiment: Virtual Agent
    defaults_version: 1
    listen: {}
    row: 28
    col: 12
    width: 12
    height: 9
  - title: "# Conversations by Category"
    name: "# Conversations by Category"
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
    listen: {}
    row: 18
    col: 12
    width: 12
    height: 8
  - title: Wait Time Tiers
    name: Wait Time Tiers
    model: call_center
    explore: transcript
    type: looker_column
    fields: [transcript__messages.number_of_messages, transcript__messages.wait_time_tier,
      transcript__messages.issue_topic]
    pivots: [transcript__messages.issue_topic]
    filters:
      transcript__messages.wait_time_tier: "-Undefined"
      transcript__messages.live_agent: 'Yes'
    sorts: [transcript__messages.wait_time_tier, transcript__messages.issue_topic]
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: aed851c8-b22d-4b01-8fff-4b02b91fe78d
      palette_id: c36094e3-d04d-4aa4-8ec7-bc9af9f851f4
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: transcript__messages.number_of_messages,
            id: transcript__messages.number_of_messages, name: Number of Messages}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    series_colors: {}
    defaults_version: 1
    listen: {}
    row: 55
    col: 0
    width: 12
    height: 8
  - title: Live Agent Performance Review
    name: Live Agent Performance Review
    model: call_center
    explore: transcript
    type: looker_grid
    fields: [agents.name, transcript.average_conversation_duration, satisfaction_ratings.average_csat,
      transcript.count, transcript__messages.average_sentiment, transcript__messages.number_of_messages,
      transcript__messages.average_wait_time, agents.hire_date]
    filters:
      transcript.conversation_start_date: 1 weeks ago for 1 weeks
      agents.name: "-NULL"
    sorts: [transcript.average_conversation_duration]
    limit: 15
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
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: d754397b-2c05-4470-bbbb-05eb4c2b15cd
      palette_id: b0768e0d-03b8-4c12-9e30-9ada6affc357
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: true
    series_labels:
      transcript__messages.number_of_messages: Number of Messages
      transcript__messages.average_wait_time: Avg Wait Time
    series_cell_visualizations:
      transcript.average_conversation_duration:
        is_active: true
        palette:
          palette_id: 31046485-0ab5-406e-b80e-e780acab5160
          collection_id: d754397b-2c05-4470-bbbb-05eb4c2b15cd
      satisfaction_ratings.average_csat:
        is_active: true
        palette:
          palette_id: 628a997f-dd44-4060-a913-250041880199
          collection_id: d754397b-2c05-4470-bbbb-05eb4c2b15cd
      transcript__messages.average_sentiment:
        is_active: true
        palette:
          palette_id: be8327bf-9384-449e-8412-84949763505b
          collection_id: d754397b-2c05-4470-bbbb-05eb4c2b15cd
      transcript__messages.number_of_messages:
        is_active: true
      transcript__messages.average_wait_time:
        is_active: true
        palette:
          palette_id: 31046485-0ab5-406e-b80e-e780acab5160
          collection_id: d754397b-2c05-4470-bbbb-05eb4c2b15cd
      transcript.count:
        is_active: true
        palette:
          palette_id: be8327bf-9384-449e-8412-84949763505b
          collection_id: d754397b-2c05-4470-bbbb-05eb4c2b15cd
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#215AC8",
        font_color: !!null '', color_application: {collection_id: d754397b-2c05-4470-bbbb-05eb4c2b15cd,
          palette_id: 628a997f-dd44-4060-a913-250041880199}, bold: false, italic: false,
        strikethrough: false, fields: []}]
    x_axis_gridlines: false
    y_axis_gridlines: false
    y_axes: [{label: '', orientation: bottom, series: [{axisId: transcript.average_conversation_duration,
            id: transcript.average_conversation_duration, name: Average Conversation
              Duration}], showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
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
    legend_position: center
    series_types: {}
    point_style: none
    series_colors:
      transcript.average_conversation_duration: "#72D16D"
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    title_hidden: true
    listen: {}
    row: 63
    col: 0
    width: 24
    height: 8
  - title: High Value At Risk Clients
    name: High Value At Risk Clients
    model: call_center
    explore: transcript
    type: single_value
    fields: [banking_client_facts.high_value_clients, client.number_of_clients]
    filters:
      transcript.count: ">0"
      transcript.conversation_start_date: 2 weeks ago for 2 weeks
      transcript__messages.message_sentiment: "<.2"
    limit: 15
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
    custom_color: "#E57947"
    comparison_label: Total At Risk
    conditional_formatting: [{type: equal to, value: !!null '', background_color: "#3EB0D5",
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: 85de97da-2ded-4dec-9dbd-e6a7d36d5825}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
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
    note_state: collapsed
    note_display: hover
    note_text: High value customers have more than $50K in account on average
    listen: {}
    row: 6
    col: 3
    width: 6
    height: 4
  - title: Number of Calls by Balance & Segmentation
    name: Number of Calls by Balance & Segmentation
    model: call_center
    explore: transcript
    type: looker_scatter
    fields: [transcript.count, client.customer_segment, client.client_id, banking_client_facts.average_daily_balance]
    pivots: [client.customer_segment]
    filters:
      transcript.count: ">=5"
      transcript.conversation_start_date: 4 weeks ago for 4 weeks
      client.client_id: not 4507
    sorts: [client.customer_segment 0]
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
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    y_axes: [{label: '', orientation: left, series: [{axisId: transcript.count, id: Middle
              Age in Rural Areas - transcript.count, name: Middle Age in Rural Areas},
          {axisId: transcript.count, id: Middle Age in Urban Areas - transcript.count,
            name: Middle Age in Urban Areas}, {axisId: transcript.count, id: Retirees
              in Rural Areas - transcript.count, name: Retirees in Rural Areas}, {
            axisId: transcript.count, id: Retirees in Urban Areas - transcript.count,
            name: Retirees in Urban Areas}, {axisId: transcript.count, id: Young Adults
              in Rural Areas - transcript.count, name: Young Adults in Rural Areas},
          {axisId: transcript.count, id: Young Adults in Urban Areas - transcript.count,
            name: Young Adults in Urban Areas}], showLabels: true, showValues: true,
        maxValue: 60, minValue: 0, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    size_by_field: transcript.count
    series_types: {}
    series_colors:
      Middle Age in Rural Areas - transcript.count: "#B1399E"
      Middle Age in Urban Areas - transcript.count: "#592EC2"
      Retirees in Rural Areas - transcript.count: "#E57947"
      Retirees in Urban Areas - transcript.count: "#FBB555"
      Young Adults in Rural Areas - transcript.count: "#C2DD67"
      Young Adults in Urban Areas - transcript.count: "#72D16D"
    hidden_fields: [client.client_id]
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen: {}
    row: 18
    col: 0
    width: 12
    height: 8
  - name: Virtual Agent Performance
    type: text
    title_text: Virtual Agent Performance
    subtitle_text: How can we make our virtual agents better?
    body_text: ''
    row: 26
    col: 0
    width: 24
    height: 2
  - title: Common Undetected Phrases (4 Words)
    name: Common Undetected Phrases (4 Words)
    model: call_center
    explore: transcript
    type: looker_grid
    fields: [ngrams__question_gram.question_gram, ngrams__question_gram.count, transcript__messages.average_sentiment]
    filters:
      transcript.conversation_start_date: 7 days
      transcript__messages.number_words_gram: '4'
      transcript.passed_to_live_agent: 'Yes'
    sorts: [ngrams__question_gram.count desc]
    limit: 20
    column_limit: 50
    row_total: right
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
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: 5591d8d1-6b49-4f8e-bafa-b874d82f8eb7
      palette_id: 18d0c733-1d87-42a9-934f-4ba8ef81d736
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    series_cell_visualizations:
      ngrams__question_gram.count:
        is_active: true
      transcript__messages.average_sentiment:
        is_active: true
        palette:
          palette_id: 5378478f-6725-4b04-89cc-75fc42da804e
          collection_id: 5591d8d1-6b49-4f8e-bafa-b874d82f8eb7
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: 1bc1f1d8-7461-4bfd-8c3b-424b924287b5,
          palette_id: ab3e6420-3e2f-42a2-802b-e4e9036b089f}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: false
    y_axes: [{label: Number of Messages, orientation: left, series: [{axisId: ngrams__question_gram.count,
            id: ngrams__question_gram.count, name: N - Grams}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: !!null '', orientation: right, series: [{axisId: transcript__messages.average_sentiment,
            id: transcript__messages.average_sentiment, name: Average Sentiment}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    size_by_field: transcript__messages.average_sentiment
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    series_types: {}
    point_style: circle
    series_colors:
      transcript__messages.average_sentiment: "#75E2E2"
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    show_null_points: true
    listen: {}
    row: 37
    col: 0
    width: 12
    height: 9
  - title: Calls by Customer Segmentation
    name: Calls by Customer Segmentation
    model: call_center
    explore: transcript
    type: looker_bar
    fields: [client.customer_segment, transcript.count, transcript__messages.issue_topic]
    pivots: [transcript__messages.issue_topic]
    sorts: [transcript.count desc 0, transcript__messages.issue_topic]
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
    stacking: percent
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
    y_axes: [{label: '', orientation: bottom, series: [{axisId: Change Personal Information
              - transcript.count, id: Change Personal Information - transcript.count,
            name: Change Personal Information}, {axisId: Credit Card - transcript.count,
            id: Credit Card - transcript.count, name: Credit Card}, {axisId: Online
              Banking - transcript.count, id: Online Banking - transcript.count, name: Online
              Banking}, {axisId: Open a New Account - transcript.count, id: Open a
              New Account - transcript.count, name: Open a New Account}, {axisId: Speak
              with an Advisor - transcript.count, id: Speak with an Advisor - transcript.count,
            name: Speak with an Advisor}, {axisId: Submit a Fraud Alert - transcript.count,
            id: Submit a Fraud Alert - transcript.count, name: Submit a Fraud Alert}],
        showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    series_types: {}
    series_colors:
      Submit a Fraud Alert - transcript.count: "#FBB555"
      Credit Card - transcript.count: "#3EB0D5"
      Change Personal Information - transcript.count: "#592EC2"
      Online Banking - transcript.count: "#75E2E2"
      Open a New Account - transcript.count: "#C2DD67"
      Speak with an Advisor - transcript.count: "#72D16D"
    defaults_version: 1
    listen: {}
    row: 12
    col: 0
    width: 9
    height: 6
  - title: Categories That Often Require Followup
    name: Categories That Often Require Followup
    model: call_center
    explore: transcript
    type: looker_donut_multiples
    fields: [transcript.count, transcript.resolved_on_call, transcript__messages.issue_topic]
    pivots: [transcript.resolved_on_call]
    fill_fields: [transcript.resolved_on_call]
    filters:
      transcript.passed_to_live_agent: 'Yes'
    sorts: [transcript.count desc 0, transcript.resolved_on_call]
    limit: 500
    column_limit: 50
    show_value_labels: true
    font_size: 10
    charts_across: 3
    color_application:
      collection_id: 5591d8d1-6b49-4f8e-bafa-b874d82f8eb7
      palette_id: 18d0c733-1d87-42a9-934f-4ba8ef81d736
      options:
        steps: 5
    series_colors:
      No - transcript.count: "#FC2E31"
      Yes - transcript.count: "#FCBF00"
    series_labels:
      No - transcript.count: Requires a Follow Up
      Yes - transcript.count: Resolved on First Touch
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 55
    col: 12
    width: 12
    height: 8
  - title: Conversation Volume
    name: Conversation Volume
    model: call_center
    explore: transcript
    type: looker_column
    fields: [transcript.count, transcript.conversation_start_hour_of_day, transcript.conversation_start_day_of_week]
    pivots: [transcript.conversation_start_hour_of_day]
    fill_fields: [transcript.conversation_start_hour_of_day, transcript.conversation_start_day_of_week]
    filters:
      transcript.conversation_start_date: 1 weeks ago for 1 weeks,NOT NULL
    sorts: [transcript.conversation_start_hour_of_day 0, transcript.conversation_start_day_of_week]
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
    stacking: ''
    limit_displayed_rows: true
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
    y_axes: [{label: '', orientation: left, series: [{axisId: transcript.count, id: 0
              - transcript.count, name: '0'}, {axisId: transcript.count, id: 1 - transcript.count,
            name: '1'}, {axisId: transcript.count, id: 2 - transcript.count, name: '2'},
          {axisId: transcript.count, id: 3 - transcript.count, name: '3'}, {axisId: transcript.count,
            id: 4 - transcript.count, name: '4'}, {axisId: transcript.count, id: 5
              - transcript.count, name: '5'}, {axisId: transcript.count, id: 6 - transcript.count,
            name: '6'}, {axisId: transcript.count, id: 7 - transcript.count, name: '7'},
          {axisId: transcript.count, id: 8 - transcript.count, name: '8'}, {axisId: transcript.count,
            id: 9 - transcript.count, name: '9'}, {axisId: transcript.count, id: 10
              - transcript.count, name: '10'}, {axisId: transcript.count, id: 11 -
              transcript.count, name: '11'}, {axisId: transcript.count, id: 12 - transcript.count,
            name: '12'}, {axisId: transcript.count, id: 13 - transcript.count, name: '13'},
          {axisId: transcript.count, id: 14 - transcript.count, name: '14'}, {axisId: transcript.count,
            id: 15 - transcript.count, name: '15'}, {axisId: transcript.count, id: 16
              - transcript.count, name: '16'}, {axisId: transcript.count, id: 17 -
              transcript.count, name: '17'}, {axisId: transcript.count, id: 18 - transcript.count,
            name: '18'}, {axisId: transcript.count, id: 19 - transcript.count, name: '19'},
          {axisId: transcript.count, id: 20 - transcript.count, name: '20'}, {axisId: transcript.count,
            id: 21 - transcript.count, name: '21'}, {axisId: transcript.count, id: 22
              - transcript.count, name: '22'}, {axisId: transcript.count, id: 23 -
              transcript.count, name: '23'}], showLabels: false, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '5'
    hide_legend: true
    series_types: {}
    series_colors:
      0 - transcript.count: "#4276BE"
      1 - transcript.count: "#4276BE"
      2 - transcript.count: "#4276BE"
      3 - transcript.count: "#4276BE"
      5 - transcript.count: "#4276BE"
      6 - transcript.count: "#4276BE"
      7 - transcript.count: "#4276BE"
      8 - transcript.count: "#4276BE"
      9 - transcript.count: "#4276BE"
      10 - transcript.count: "#4276BE"
      11 - transcript.count: "#4276BE"
      12 - transcript.count: "#4276BE"
      13 - transcript.count: "#4276BE"
      14 - transcript.count: "#4276BE"
      23 - transcript.count: "#4276BE"
      22 - transcript.count: "#4276BE"
      21 - transcript.count: "#4276BE"
      20 - transcript.count: "#4276BE"
      19 - transcript.count: "#4276BE"
      18 - transcript.count: "#4276BE"
      17 - transcript.count: "#4276BE"
      16 - transcript.count: "#4276BE"
      15 - transcript.count: "#4276BE"
      4 - transcript.count: "#4276BE"
    defaults_version: 1
    show_null_points: true
    interpolation: linear
    listen: {}
    row: 12
    col: 14
    width: 10
    height: 6
  - title: Areas Where Calls Are Shorter with Live Agent
    name: Areas Where Calls Are Shorter with Live Agent
    model: call_center
    explore: transcript
    type: looker_column
    fields: [transcript__messages.issue_topic, transcript__messages.live_agent, transcript.average_conversation_duration]
    pivots: [transcript__messages.live_agent]
    fill_fields: [transcript__messages.live_agent]
    sorts: [transcript__messages.live_agent 0, transcript__messages.issue_topic desc]
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
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
      palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: transcript.average_conversation_duration,
            id: No - transcript.average_conversation_duration, name: Virtual Agent},
          {axisId: transcript.average_conversation_duration, id: Yes - transcript.average_conversation_duration,
            name: Live Agent}], showLabels: true, showValues: true, minValue: !!null '',
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    series_types: {}
    series_colors:
      No - transcript.average_conversation_duration: "#E57947"
      Yes - transcript.average_conversation_duration: "#6A013A"
    series_labels:
      Yes - transcript__messages.average_sentiment: Live Agent
      No - transcript__messages.average_sentiment: Virtual Agent
      No - transcript.average_conversation_duration: Virtual Agent
      Yes - transcript.average_conversation_duration: Live Agent
    defaults_version: 1
    listen: {}
    row: 37
    col: 12
    width: 12
    height: 9
  - title: Repeat Callers
    name: Repeat Callers
    model: call_center
    explore: transcript
    type: looker_pie
    fields: [transcript.count, transcript.is_first_call]
    fill_fields: [transcript.is_first_call]
    sorts: [transcript.count desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: table_calculation, label: Percent of Total, value_format: !!null '',
        value_format_name: percent_2, calculation_type: percent_of_column_sum, table_calculation: percent_of_total,
        args: [transcript.count], _kind_hint: measure, _type_hint: number, is_disabled: true}]
    value_labels: labels
    label_type: labPer
    inner_radius: 50
    color_application:
      collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a
      palette_id: 93f8aeb4-3f4a-4cd7-8fee-88c3417516a1
      options:
        steps: 5
    series_colors: {}
    series_labels:
      'No': Repeat
      'Yes': First
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
    show_value_labels: false
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
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_null_points: true
    interpolation: linear
    hidden_fields: []
    hidden_points_if_no: []
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    listen: {}
    row: 12
    col: 9
    width: 5
    height: 6
  - title: Call Volume by Months Since Signup
    name: Call Volume by Months Since Signup
    model: call_center
    explore: transcript
    type: looker_line
    fields: [transcript.months_since_signup, transcript.count, banking_client_facts.average_daily_balance_tier]
    pivots: [banking_client_facts.average_daily_balance_tier]
    fill_fields: [banking_client_facts.average_daily_balance_tier]
    filters:
      transcript.months_since_signup: ">=0"
    sorts: [transcript.count desc 0, banking_client_facts.average_daily_balance_tier]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: calls_per_client, label: Calls per Client,
        expression: "${transcript.count}/${client.number_of_clients}", value_format: !!null '',
        value_format_name: !!null '', _kind_hint: measure, _type_hint: number, is_disabled: true}]
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
    show_null_points: true
    interpolation: monotone
    hidden_series: [Below 1000 - 0 - transcript.count]
    series_colors:
      M - transcript.count: "#4276BE"
      F - transcript.count: "#75E2E2"
      Below 1000 - 0 - transcript.count: "#E57947"
      10000 or Above - 4 - transcript.count: "#FBB555"
      1000 to 1999 - 1 - transcript.count: "#4276BE"
    defaults_version: 1
    hidden_fields:
    listen: {}
    row: 46
    col: 0
    width: 24
    height: 7
