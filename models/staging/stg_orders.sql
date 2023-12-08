
    select
      id as order_id,
      user_id as customer_id,
      status,
      order_date,
      left(cast(order_date as string),7) as year_month
    from `dbt-tutorial`.jaffle_shop.orders