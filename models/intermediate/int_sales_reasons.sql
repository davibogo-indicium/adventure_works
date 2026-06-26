with
    sales_order_headers_connector_sales_reasons as (
        select *
        from {{ ref('stg_erp__sales_order_header_sales_reason') }}
    )

    , sales_reasons as (
        select *
        from {{ ref('stg_erp__sales_reason') }}
    )

    , sales_order_sales_reason_joined as (
        select
            sales_reasons.pk_sales_reason
            , sales_order_headers_connector_sales_reasons.fk_sales_order_header
            , sales_reasons.sales_reason_name
            , sales_reasons.sales_reason_type
        from sales_order_headers_connector_sales_reasons
        inner join sales_reasons on sales_order_headers_connector_sales_reasons.fk_sales_reason = sales_reasons.pk_sales_reason
    )

select *
from sales_order_sales_reason_joined