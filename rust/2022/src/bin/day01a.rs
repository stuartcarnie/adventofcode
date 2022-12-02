use itertools::Itertools;
use input::day01::INPUT;

fn main() {
    let sums = INPUT
        .lines()
        .group_by(|v| { *v != "" })
        .into_iter()
        .map(|(_, g)| { g.filter_map(|s| s.parse::<i32>().ok()).sum::<i32>() })
        .sorted()
        .rev()
        .collect::<Vec<_>>();
    println!("{}", sums[0]);
}
