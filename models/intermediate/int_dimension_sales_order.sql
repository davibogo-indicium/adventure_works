with
    sales_orders_details as (
        select *
        from {{ ref('stg_crm__sales_order_detail') }}
    )

    , sales_orders_headers as (
        select *
        from {{ ref('stg_crm__sales_order_header') }}
    )

    , sales_orders_headers_sales_reasons as (
        select *
        from {{ ref('stg_crm__sales_order_header_sales_reason') }}
    )

    , sales_reasons as (
        select *
        from {{ ref('stg_crm__sales_reason') }}
    )

    , customers as (
        select *
        from {{ ref('stg_crm__customer') }}
    )

    , people as (
        select *
        from {{ ref('stg_crm__person') }}
    )

    , products as (
        select *
        from {{ ref('stg_crm__product') }}
    )

    , cards as (
        select *
        from {{ ref('stg_crm__credit_card') }}
    )

    , sales_order_enriched as (
        select
            {{ dbt_utils.generate_surrogate_key(['sales_orders_headers.pk_sales_order_header'
                , 'products.pk_product', 'customers.pk_customer', 'people.pk_person', 'cards.pk_card'
                , 'sales_reason.pk_sales_reason']) }} as pk_order_details
            , people.person_name as client_name
            , products.product_name
            , cards.card_type
            , sales_reasons.sales_reason_name
            , sales_orders_headers.sales_order_status
        from sales_orders_headers
        left join sales_orders_details on sales_orders_details.fk_sales_order_header = sales_orders_headers.pk_sales_order_header
        left join products on sales_orders_details.fk_product = products.pk_product
        left join customers on sales_orders_headers.fk_customer = customers.pk_customer
        left join people on customers.fk_person = people.pk_person
        left join cards on sales_orders_headers.fk_credit_card = cards.pk_credit_card
        left join sales_orders_headers_sales_reasons on sales_orders_headers_sales_reasons.fk_sales_order_header = sales_orders_headers.pk_sales_order_header
        left join sales_reasons on sales_orders_headers_sales_reasons.fk_sales_reason = sales_reasons.pk_sales_reason
    )

select *
from sales_order_enriched