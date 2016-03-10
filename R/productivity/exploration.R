source("loader/monthly_persistence_stats.R")

month_stats = load.monthly_persistence_stats()

svg("productivity/plots/persistent_tokens.by_month.svg",
    height=5, width=7)
ggplot(
    month_stats[,list(ns_ptokens = sum(ns_ptokens)), list(month)],
    aes(
        month,
        ns_ptokens
    )
) +
theme_bw() +
geom_bar(fill="#e6e6e6", color="black", stat="identity") +
scale_x_date(limits=as.Date(c("2001-01-01", "2015-05-01"))) +
scale_y_continuous("Non-self persisting tokens")
dev.off()


month_stats$editor_type = with(
    month_stats,
    mapply(
        function(user_type, tool_used){
            if(user_type == "registered"){
                if(is.na(tool_used)){
                    'registered-manual'
                }else{
                    'tool-assisted'
                }
            }else{
                as.character(user_type)
            }
        },
        user_type,
        tool_used
    )
)


svg("productivity/plots/persistent_tokens.by_month_and_type.svg",
    height=5, width=7)
ggplot(
    month_stats[,list(ns_ptokens = sum(ns_ptokens)), list(month, editor_type)],
    aes(
        month,
        ns_ptokens,
        group=editor_type
    )
) +
theme_bw() +
geom_line(aes(color=editor_type), linetype=3) +
geom_smooth(aes(color=editor_type), span=0.25, se=F) +
scale_x_date(limits=as.Date(c("2001-01-01", "2015-05-01"))) +
scale_y_continuous("Non-self persisting tokens")
dev.off()

svg("productivity/plots/persistent_token_prop.by_month_and_type.svg",
    height=5, width=7)
ggplot(
    rbind(
        merge(
            month_stats[user_type == "IP",list(ns_ptokens=sum(ns_ptokens)),month],
            month_stats[,list(ns_ptokens=sum(ns_ptokens)),month],
            by="month",
            suffixes=c("", ".total")
        )[,list(month, prop=ns_ptokens/ns_ptokens.total, group="IP"),],
        merge(
            month_stats[user_type == "bot",list(ns_ptokens=sum(ns_ptokens)),month],
            month_stats[,list(ns_ptokens=sum(ns_ptokens)),month],
            by="month",
            suffixes=c("", ".total")
        )[,list(month, prop=ns_ptokens/ns_ptokens.total, group="bot"),],
        merge(
            month_stats[user_type == "registered" & !is.na(tool_used),list(ns_ptokens=sum(ns_ptokens)),month],
            month_stats[,list(ns_ptokens=sum(ns_ptokens)),month],
            by="month",
            suffixes=c("", ".total")
        )[,list(month, prop=ns_ptokens/ns_ptokens.total, group="tool-assisted"),]
    ),
    aes(
        month,
        prop,
        group=group
    )
) +
theme_bw() +
geom_line(aes(color=group), linetype=3) +
geom_smooth(aes(color=group), span=0.25, se=F) +
scale_x_date(limits=as.Date(c("2004-01-01", "2015-05-01"))) +
scale_y_continuous("Proportion of Non-self persisting tokens", limits=c(-0.005, 0.27))
dev.off()


month_stats[user_type == "registered",
            list(ns_ptokens = sum(ns_ptokens)),
            list(tool_used)]


svg("productivity/plots/persistent_tokens.by_month_and_tool_used.svg",
    height=5, width=7)
ggplot(
    month_stats[user_type == "registered" &
                tool_used %in% c("awb", "ohconfucius", "reflinks", "autoed", "refill"),
                list(ns_ptokens = sum(ns_ptokens)),
                list(month, tool_used)],
    aes(
        month,
        ns_ptokens,
        group=tool_used
    )
) +
theme_bw() +
geom_line(aes(color=tool_used), linetype=3) +
geom_smooth(aes(color=tool_used), span=1, se=F) +
scale_x_date(limits=as.Date(c("2001-01-01", "2015-05-01"))) +
scale_y_continuous("Non-self persisting tokens")
dev.off()
