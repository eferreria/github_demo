# If necessary, uncomment the line below to include explore_source.

# include: "github_demo_yadid.model.lkml"

view: customer_order_summary {
  derived_table: {
    explore_source: events {
      column: country { field: users.country }
      column: id { field: users.id }
      column: total_sale { field: order_items.total_amount_of_order_usd }
      column: count { field: order_items.count }
      column: traffic_source {}
    }
  }
  dimension: country {}
  dimension: id {
    label: "Users User ID"
    type: number
  }
  dimension: total_amount_of_order_usd {
    value_format: "$#,##0.00"
    type: number
  }
  dimension: count {
    type: number
  }
  dimension: traffic_source {}
}
