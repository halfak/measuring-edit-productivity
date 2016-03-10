source("loader/per_user_persistence_stats.R")

month_stats = load.per_user_persistence_stats()

svg("productivity/plots/persistent_tokens.jimbo_wales.by_month.svg",
    height=5, width=7)
ggplot(
    month_stats[user_name == "Jimbo Wales",],
    aes(
        month,
        ns_ptokens
    )
) +
theme_bw() +
geom_area(aes(y=cumsum(ns_ptokens)), fill="#00FF00", alpha=0.2) +
geom_bar(stat="identity", fill="#e6e6e6", color="black") +
geom_line(aes(y=cumsum(ns_ptokens)), color="#008800") +
scale_y_continuous("Non-self persisting tokens")
dev.off()

svg("productivity/plots/persistent_tokens.epochfail.by_month.svg",
    height=5, width=7)
ggplot(
    month_stats[user_name == "EpochFail",],
    aes(
        month,
        ns_ptokens
    )
) +
theme_bw() +
geom_area(aes(y=cumsum(ns_ptokens)), fill="#00FF00", alpha=0.2) +
geom_bar(stat="identity", fill="#e6e6e6", color="black") +
geom_line(aes(y=cumsum(ns_ptokens)), color="#008800") +
scale_y_continuous("Non-self persisting tokens")
dev.off()

svg("productivity/plots/persistent_tokens.dgg.by_month.svg",
    height=5, width=7)
ggplot(
    month_stats[user_name == "DGG",],
    aes(
        month,
        ns_ptokens
    )
) +
theme_bw() +
geom_area(aes(y=cumsum(ns_ptokens)), fill="#00FF00", alpha=0.2) +
geom_bar(stat="identity", fill="#e6e6e6", color="black") +
geom_line(aes(y=cumsum(ns_ptokens)), color="#008800") +
scale_y_continuous("Non-self persisting tokens")
dev.off()

svg("productivity/plots/persistent_tokens.ladsgroup.by_month.svg",
    height=5, width=7)
ggplot(
    month_stats[user_name == "Ladsgroup",],
    aes(
        month,
        ns_ptokens
    )
) +
theme_bw() +
geom_area(aes(y=cumsum(ns_ptokens)), fill="#00FF00", alpha=0.2) +
geom_bar(stat="identity", fill="#e6e6e6", color="black") +
geom_line(aes(y=cumsum(ns_ptokens)), color="#008800") +
scale_y_continuous("Non-self persisting tokens")
dev.off()

svg("productivity/plots/persistent_tokens.guillom.by_month.svg",
    height=5, width=7)
ggplot(
    month_stats[user_name == "Guillom",],
    aes(
        month,
        ns_ptokens
    )
) +
theme_bw() +
geom_area(aes(y=cumsum(ns_ptokens)), fill="#00FF00", alpha=0.2) +
geom_bar(stat="identity", fill="#e6e6e6", color="black") +
geom_line(aes(y=cumsum(ns_ptokens)), color="#008800") +
scale_y_continuous("Non-self persisting tokens")
dev.off()

svg("productivity/plots/persistent_tokens.ironholds.by_month.svg",
    height=5, width=7)
ggplot(
    month_stats[user_name == "Ironholds",],
    aes(
        month,
        ns_ptokens
    )
) +
theme_bw() +
geom_area(aes(y=cumsum(ns_ptokens)), fill="#00FF00", alpha=0.2) +
geom_bar(stat="identity", fill="#e6e6e6", color="black") +
geom_line(aes(y=cumsum(ns_ptokens)), color="#008800") +
scale_y_continuous("Non-self persisting tokens")
dev.off()
