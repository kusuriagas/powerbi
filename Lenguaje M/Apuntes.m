Text.Contains([BACK],"MTA") and [FECHA_DE_LLAMADA]<>null and [FECHA_DE_LLAMADA]<>"" then [FECHA_DE_LLAMADA]&" "&[HORA_DE_LLAMADA]

FECRESU = Table.AddColumn(#"TipoDato Datetime", "FEC_RESU", each Date.ToText(DateTime.Date ([FECHA_INICIO]), "dd-MMM")),
    AÑO = Table.AddColumn(FECRESU, "AÑO", each Date.ToText(DateTime.Date ([FECHA_INICIO]),"yyyy")),
    MES = Table.AddColumn(AÑO, "MES", each Text.Upper(Date.ToText(DateTime.Date ([FECHA_INICIO]), "MMMM"))),
    DIA_RESU = Table.AddColumn(MES, "DIA_RESU", each Date.ToText(DateTime.Date ([FECHA_INICIO]), "dd")),

SLA = Table.AddColumn(AGRU_SEM_IV, "SLA", each 
                 if [ESTADO_DE_GESTION_1] = "INGRESADO" and [FECHA_FIN_RG1]=null    then "24h"
            else if [ESTADO_DE_GESTION_1] = "INGRESADO" and Duration.TotalHours([FECHA_FIN_RG1]-[FECHA_INICIO])<2  then "2h" 
            else if [ESTADO_DE_GESTION_1] = "INGRESADO" and Duration.TotalHours([FECHA_FIN_RG1]-[FECHA_INICIO])>=2 and  Duration.TotalHours([FECHA_FIN_RG1]-[FECHA_INICIO])<6   then "6h"
            else if [ESTADO_DE_GESTION_1] = "INGRESADO" and Duration.TotalHours([FECHA_FIN_RG1]-[FECHA_INICIO])>=6 and  Duration.TotalHours([FECHA_FIN_RG1]-[FECHA_INICIO])<12  then "12h"
            else if [ESTADO_DE_GESTION_1] = "INGRESADO" and Duration.TotalHours([FECHA_FIN_RG1]-[FECHA_INICIO])>=12 and Duration.TotalHours([FECHA_FIN_RG1]-[FECHA_INICIO])<24  then "24h"
            else if [ESTADO_DE_GESTION_1] = "INGRESADO" and Duration.TotalHours([FECHA_FIN_RG1]-[FECHA_INICIO])>=24 then ">24h"                           
            else  "-"),

