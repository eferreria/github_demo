view: products {
  sql_table_name: "PUBLIC"."PRODUCTS"
    ;;
  drill_fields: [id]

  dimension: id {
    label: "Product ID"
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}."BRAND" ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}."CATEGORY" ;;
    drill_fields: [brand, cost, department]
  }

  dimension: cost {
    type: number
    sql: ${TABLE}."COST" ;;
  }

  measure: avg_cost {
    type: average
    sql: ${cost} ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}."DEPARTMENT" ;;
  }

  dimension: distribution_center_id {
    type: number
    sql: ${TABLE}."DISTRIBUTION_CENTER_ID" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
    drill_fields: [brand, category, department, retail_price]
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}."RETAIL_PRICE" ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}."SKU" ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name, inventory_items.count]
  }
}
