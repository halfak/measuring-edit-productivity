source("loader/token_persistence_sample.R")

tokens = load.token_persistence_sample()

svg("survival/plots/time_visible.density.svg", height=5, width=7)
ggplot(
    tokens[seconds_possible > 60*60*24*3 &
           contains_letters,],
    aes(x=seconds_visible/(60*60))
) +
theme_bw() +
geom_density(
    fill="#CCCCCC",
    color="#000000"
) +
scale_x_continuous(
    "Time visible when removed",
    limits=c(0, 24*3),
    breaks=c(0, 1, 5, 10, 24, 48, 72),
    labels=c("0", "1h", "5h", "10h", "24h", "48h", "72h")
)
dev.off()

hours_visible.survival = with(
    tokens[contains_letters == T,],
    survival(pmin(24*3+1, round(seconds_visible/(60*60))),
             seconds_possible < 60*60*24*3)
)
svg("survival/plots/hours_visible.hazard.svg", height=5, width=7)
ggplot(
    hours_visible.survival,
    aes(x=time_unit, y=hazard)
) +
theme_bw() +
geom_ribbon(
    width=0,
    aes(
        ymax=hazard.beta.se.upper,
        ymin=hazard.beta.se.lower
    ),
    color="#CCCCCC",
    fill="#CCCCCC"
) +
geom_line(
    linetype=2
) +
scale_x_continuous(
    "Time visible",
    limits=c(0, 24*3),
    breaks=c(1, 5, 10, 24, 48, 72),
    labels=c("1h", "5h", "10h", "24h", "48h", "72h")
) +
scale_y_continuous(
    "Hazard of permanent removal",
    limits=c(0, 0.25)
)
dev.off()


persisted.survival = with(
    tokens[contains_letters == T,],
    survival(pmin(persisted, 50+1), revisions_processed < 50 | persisted >= 50)
)
svg("survival/plots/revisions_persisted.hazard.svg", height=5, width=7)
ggplot(
    persisted.survival,
    aes(x=time_unit, y=hazard)
) +
theme_bw() +
geom_ribbon(
    width=0,
    aes(
        ymax=hazard.beta.se.upper,
        ymin=hazard.beta.se.lower
    ),
    color="#CCCCCC",
    fill="#CCCCCC"
) +
geom_line(
    linetype=2
) +
scale_x_continuous(
    "Revisions persisted",
    limits=c(0,40),
    breaks=c(0, 5, 10, 25, 40)
)
dev.off()


non_self_persisted.survival = with(
    tokens[contains_letters == T,],
    survival(pmin(non_self_persisted, 50+1), non_self_processed < 50 | non_self_persisted >= 50)
)
svg("survival/plots/non_self_persisted.hazard.svg", height=5, width=7)
ggplot(
    non_self_persisted.survival,
    aes(x=time_unit, y=hazard)
) +
theme_bw() +
geom_ribbon(
    width=0,
    aes(
        ymax=hazard.beta.se.upper,
        ymin=hazard.beta.se.lower
    ),
    color="#CCCCCC",
    fill="#CCCCCC"
) +
geom_line(
    linetype=2
) +
scale_x_continuous(
    "Revisions persisted",
    limits=c(0,40),
    breaks=c(0, 5, 10, 25, 40)
)
dev.off()
