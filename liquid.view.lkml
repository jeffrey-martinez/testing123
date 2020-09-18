view_name: imported_view {
  
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
      sql: ${_date} >= ${date_period_start_date_comparison_period} ;;
    }
    
    
  
  }
