
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

 with cte as (

    select * from {{ ref('stg_orders')}}

 ), monthlyaggregate as (
  
  select 
    year_month, 
    sum(case when status = 'placed' then 1 else 0 end) orders_placed,
    sum(case when status = 'shipped' then 1 else 0 end) orders_shipped,
    sum(case when status = 'returned' then 1 else 0 end) orders_returned,
    sum(case when status = 'completed' then 1 else 0 end) orders_completed
  from cte
  group by 1

 )
 select 
    year_month,
    orders_placed,
    orders_shipped,
    orders_returned,
    orders_completed
 from monthlyaggregate

 order by 1


/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
