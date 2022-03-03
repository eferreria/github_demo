view: order_items {
  sql_table_name: "PUBLIC"."ORDER_ITEMS"
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}."CREATED_AT" ;;
  }

  dimension_group: delivered {
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
    sql: ${TABLE}."DELIVERED_AT" ;;
  }

  dimension: inventory_item_id {
    type: number
    hidden: yes
    sql: ${TABLE}."INVENTORY_ITEM_ID" ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}."ORDER_ID" ;;
  }

  dimension_group: returned {
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
    sql: ${TABLE}."RETURNED_AT" ;;
  }

 # dimension: returned_status {
  #  type: yesno
  #}

  #measure: returned_count {
  #  type: count_distinct
  #  sql: sql: ${TABLE}."ID";;
   # drill_fields: [detail*]
   # filters: [returned_status: "Yes"]  }

  measure: sale_price {
    type: number
    sql: ${TABLE}."SALE_PRICE" ;;
    value_format: "$#.00;($#.00)"
  }

  measure: total_amount_of_order_usd {
    type: sum
    sql:${TABLE}."SALE_PRICE" ;;
    value_format: "$#.00;($#.00)"
  }

  measure: avg_sale_price {
    type: average
    sql: ${TABLE}."SALE_PRICE" ;;
    value_format_name: usd
  }

  dimension: total_amount_of_order_tier {
    type: tier
    sql: sum(${TABLE}."SALE_PRICE" ) ;;
    tiers: [0, 10, 50, 150, 500, 1000]
  }


  dimension_group: shipped {
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
    sql: ${TABLE}."SHIPPED_AT" ;;
  }
  dimension: shipping_days {
    type: number
    sql: date_diff(${shipped_date}, ${created_date}, DAY) ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
  }

  dimension: user_id {
    type: number
    hidden: yes
    sql: ${TABLE}."USER_ID" ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.first_name,
      users.id,
      users.last_name,
      inventory_items.id,
      inventory_items.product_name
    ]
  }
}
