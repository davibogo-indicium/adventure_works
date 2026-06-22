with
    sales_orders_details as (
        select *
        from {{ ref('stg_erp__sales_order_detail') }}
    )

    , sales_orders_headers as (
        select *
        from {{ ref('stg_erp__sales_order_header') }}
    )

    , sales_orders_headers_sales_reasons as (
        select *
        from {{ ref('stg_erp__sales_order_header_sales_reason') }}
    )

    , sales_reasons as (
        select *
        from {{ ref('stg_erp__sales_reason') }}
    )

    , customers as (
        select *
        from {{ ref('stg_erp__customer') }}
    )

    , people as (
        select *
        from {{ ref('stg_erp__person') }}
    )

    , products as (
        select *
        from {{ ref('stg_erp__product') }}
    )

    , cards as (
        select *
        from {{ ref('stg_erp__credit_card') }}
    )

    , addresses as (
        select *
        from {{ ref('stg_erp__address') }}
    )

    , sales_order_enriched as (
        select
            {{ dbt_utils.generate_surrogate_key(['sales_orders_headers.pk_sales_order_header'
                , 'products.pk_product', 'customers.pk_customer', 'people.pk_person', 'cards.pk_card'
                , 'sales_reasons.pk_sales_reason']) }} as sk_sales_order_detail
            , people.person_name as client_name
            , products.product_name
            , cards.card_type
            , sales_reasons.sales_reason_name
            , sales_orders_headers.sales_order_status
            , sales_orders_headers.pk_sales_order_header
            , sales_orders_headers.fk_address
            , sales_orders_headers.sales_order_dt
            , sales_orders_details.item_price
            , sales_orders_details.item_price_discount
            , sales_orders_details.item_quantity
        from sales_orders_headers
        inner join sales_orders_details on sales_orders_details.fk_sales_order_header = sales_orders_headers.pk_sales_order_header
        left join products on sales_orders_details.fk_product = products.pk_product
        left join customers on sales_orders_headers.fk_customer = customers.pk_customer
        left join people on customers.fk_person = people.pk_person
        left join cards on sales_orders_headers.fk_card = cards.pk_card
        left join sales_orders_headers_sales_reasons on sales_orders_headers_sales_reasons.fk_sales_order_header = sales_orders_headers.pk_sales_order_header
        left join sales_reasons on sales_orders_headers_sales_reasons.fk_sales_reason = sales_reasons.pk_sales_reason
    )

    , sales_order_header_metrics as (
        select
            sk_sales_order_detail
            , pk_sales_order_header
            , fk_address
            , client_name
            , product_name
            , card_type
            , sales_reason_name
            , sales_order_status
            , sales_order_dt
            , item_quantity
            , item_price
            , item_price_discount
            , item_price * item_quantity as gross_total
            , item_price * (1 - item_price_discount) * item_quantity as net_total
        from sales_order_enriched
    )

select *
from sales_order_header_metrics