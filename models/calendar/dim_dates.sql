/* gerando datas usando a macro do pacote dbt-utils */
with
    dates_raw as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('1970-01-01' as date)",
        end_date="dateadd(year, 100, to_date(current_date()))"
        )
    }}
)

/* extraindo algumas informações da data e renomeando algumas colunas para o português */
    , days_info as (
        select
            cast(date_day as date) as data_dia
            , dayofweek(date_day) as dia_da_semana
            , extract(month from date_day) as mes
            , extract(quarter from date_day) as trimestre
            , extract(dayofyear from date_day) as dia_do_ano
            , extract(year from date_day) as ano
            , to_char(date_day, 'DD-MM') AS dia_mes
        from dates_raw
    )

/* renomeando os significados das colunas, traduzindo-os para o português */
    , days_named as (
        select
            *
            , case
                when dia_da_semana = 1 then 'Segunda-feira'
                when dia_da_semana = 2 then 'Terça-feira'
                when dia_da_semana = 3 then 'Quarta-feira'
                when dia_da_semana = 4 then 'Quinta-feira'
                when dia_da_semana = 5 then 'Sexta-feira'
                when dia_da_semana = 6 then 'Sábado'
                when dia_da_semana = 0 then 'Domingo'
            end as nome_do_dia
            , case
                when mes = 1 then 'Janeiro'
                when mes = 2 then 'Fevereiro'
                when mes = 3 then 'Março'
                when mes = 4 then 'Abril'
                when mes = 5 then 'Maio'
                when mes = 6 then 'Junho'
                when mes = 7 then 'Julho'
                when mes = 8 then 'Agosto'
                when mes = 9 then 'Setembro'
                when mes = 10 then 'Outubro'
                when mes = 11 then 'Novembro'
                else 'Dezembro'
            end as nome_do_mes
            , case
                when mes = 1 then 'Jan'
                when mes = 2 then 'Fev'
                when mes = 3 then 'Mar'
                when mes = 4 then 'Abr'
                when mes = 5 then 'Mai'
                when mes = 6 then 'Jun'
                when mes = 7 then 'Jul'
                when mes = 8 then 'Ago'
                when mes = 9 then 'Set'
                when mes = 10 then 'Out'
                when mes = 11 then 'Nov'
                else 'Dez'
            end as abrev_do_mes
            , case
                when trimestre = 1 then '1º Trimestre'
                when trimestre = 2 then '2º Trimestre'
                when trimestre = 3 then '3º Trimestre'
                else '4º Trimestre'
            end as nome_trimestre
            , case
                when trimestre in(1,2) then 1
                else 2
            end as semestre
            , case
                when trimestre in(1,2) then '1º Semestre'
                else '2º Semestre'
            end as nome_semestre
        from days_info
    )

    , flags_cte as (
        /*flags de feriado e dia util*/
        select
            *
            , case
                when dia_mes = '01-01' then true
                when dia_mes = '21-04' then true
                when dia_mes = '01-05' then true
                when dia_mes = '07-09' then true
                when dia_mes = '12-10' then true
                when dia_mes = '02-11' then true
                when dia_mes = '15-11' then true
                when dia_mes = '25-12' then true
                else false
            end as fl_feriado
            , case
                when dia_da_semana in(6, 0) then false
                when dia_mes = '01-01' then false
                when dia_mes = '21-04' then false
                when dia_mes = '01-05' then false
                when dia_mes = '07-09' then false
                when dia_mes = '12-10' then false
                when dia_mes = '02-11' then false
                when dia_mes = '15-11' then false
                when dia_mes = '25-12' then false
                else true
            end as fl_dia_util
            , coalesce(dia_da_semana in(6, 0), false) as fl_final_semana
        from days_named
    )

/* reorganizando as colunas */
    , final_cte as (
        select
            data_dia
            , dia_da_semana
            , nome_do_dia
            , mes
            , nome_do_mes
            , abrev_do_mes
            , trimestre
            , nome_trimestre
            , semestre
            , nome_semestre
            , fl_feriado
            , fl_dia_util
            , fl_final_semana
            , dia_do_ano
            , ano
        from flags_cte
    )

select *
from final_cte