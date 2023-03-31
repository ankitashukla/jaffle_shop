{% macro cents(column_name, decimal_places='123') %}
round( 1.0 * {{ column_name }} / 100, {{decimal_places}} )
{% endmacro %}

 