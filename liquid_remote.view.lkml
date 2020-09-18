view: liquid_remote {

    parameter: period {
      description: "Prior Period for Comparison"
      type: string
          allowed_value: {
            value: "day"
            label: "Day"
          }
          allowed_value: {
            value: "week"
            label: "Week (Mon - Sun)"
          }
          allowed_value: {
            value: "month"
            label: "Month"
          }
          allowed_value: {
            value: "quarter"
            label: "Quarter"
          }
          allowed_value: {
            value: "year"
            label: "Year"
          }
          allowed_value: {
            value: "7 day"
            label: "Last 7 Days"
          }
          allowed_value: {
            value: "28 day"
            label: "Last 28 Days"
          }
          allowed_value: {
            value: "91 day"
            label: "Last 91 Days"
          }
          allowed_value: {
            value: "364 day"
            label: "Last 364 Days"
          }
          default_value: "7 day"
       }
  
    dimension: date_period_start_date_comparison_period {
      sql: DATETIME_ADD(CURRENT_DATETIME(), INTERVAL -2
        {% if period._parameter_value contains "day" %}
          {% if period._parameter_value == "'7 day'" %}*7 DAY
          {% elsif period._parameter_value == "'28 day'" %}*28 DAY
          {% elsif period._parameter_value == "'91 day'" %}*91 DAY
          {% elsif period._parameter_value == "'364 day'" %}*364 DAY
          {% else %} DAY
          {% endif %}
        {% elsif period._parameter_value contains "week" %} WEEK
        {% elsif period._parameter_value contains "month" %} MONTH
        {% elsif period._parameter_value contains "quarter" %} QUARTER
        {% elsif period._parameter_value contains "year" %} YEAR
        {% endif %}) ;;
    }
    
    dimension: date_period_comparison_period {
      hidden: yes
      description: "Is the selected period (This Period) in the last two periods?"
      type: yesno
      group_label: "Event"
      sql: ${date} >= ${date_period_start_date_comparison_period} ;;
    }
    
    
  
  }
