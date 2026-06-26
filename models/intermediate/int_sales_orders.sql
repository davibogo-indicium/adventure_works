with
    sales_orders_details as (
        select *
        from {{ ref('stg_erp__sales_order_detail') }}
    )

    , sales_orders_headers as (
        select *
        from {{ ref('stg_erp__sales_order_header') }}
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

    , customers as (
        select *
        from {{ ref('int_customers') }}
    )

    , sales_order_enriched as (
        select
            {{ dbt_utils.generate_surrogate_key(['sales_orders_headers.pk_sales_order_header'
                , 'products.pk_product', 'customers.pk_customer', 'cards.pk_card']) }} as sk_sales_order_detail
            , customers.customer_name as customer_name
            , products.product_name
            , cards.card_type
            , sales_orders_headers.sales_order_dt
            , sales_orders_headers.sales_order_status
            , sales_orders_headers.pk_sales_order_header
            , sales_orders_headers.fk_address
            , sales_orders_details.item_price
            , sales_orders_details.item_price_discount
            , sales_orders_details.item_quantity
        from sales_orders_headers
        inner join sales_orders_details on sales_orders_details.fk_sales_order_header = sales_orders_headers.pk_sales_order_header
        left join products on sales_orders_details.fk_product = products.pk_product
        left join customers on sales_orders_headers.fk_customer = customers.pk_customer
        left join cards on sales_orders_headers.fk_card = cards.pk_card
    )

    , sales_order_header_metrics as (
        select
            sk_sales_order_detail
            , customer_name
            , product_name
            , card_type
            , sales_order_dt
            , sales_order_status
            , pk_sales_order_header
            , fk_address
            , item_price
            , item_price_discount
            , item_quantity
            , item_price * item_quantity as gross_total
            , item_price * (1 - item_price_discount) * item_quantity as net_total
        from sales_order_enriched
    )

select *
from sales_order_header_metrics