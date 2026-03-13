with
    sales_orders_details as (
        select *
        from {{ ref('stg_crm__sales_order_detail') }}
    )

    , sales_orders_headers as (
        select *
        from {{ ref('stg_crm__sales_order_header') }}
    )

    facts_enriched as (
        select
            {{ dbt_utils.generate_surrogate_key(['sales_orders_headers.pk_sales_order_header'
                , 'products.pk_product', 'customers.pk_customer', 'people.pk_person', 'cards.pk_card'
                , 'sales_reason.pk_sales_reason']) }} as fk_order_details
        from sales_orders_headers
        left join sales_orders_details on sales_orders_details.fk_sales_order_header = sales_orders_headers.pk_sales_order_header
    )