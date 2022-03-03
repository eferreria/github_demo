connection: "snowlooker"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/view.lkml"                   # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

label: "Yadid's E-Commerce Order Details"


explore: order_items {
  join: users {
    type: left_outer
    relationship: many_to_one
    sql_on: ${order_items.user_id} = ${users.id} ;;
  }
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id};;
    relationship: many_to_one
  }
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id};;
    relationship: many_to_one
  }
    access_filter: {
      field: products.category
      user_attribute: row_level_security_example_yadid
    }
}

explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
  join: order_items {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}
explore:  customer_order_summary{
}

access_grant: user_id {
  user_attribute: contractor_example_yadid
  allowed_values: ["1", "2", "3", "4", "5"]
}
