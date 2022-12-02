use itertools::Itertools;
use input::day01::INPUT;

fn main() {
    let sums = INPUT
        .lines()
        // create groups, breaking each time an empty string is observed
        .group_by(|v| { *v != "" })
        .into_iter()
        // convert all the strings to i32s, skipping any that fail to parse (i.e. empty strings)
        .map(|(_, g)| { g.filter_map(|s| s.parse::<i32>().ok()).sum::<i32>() })
        // sort the integers
        .sorted()
        // reverse their order
        .rev()
        // collect them into a vector
        .collect::<Vec<_>>();
    println!("{}", sums[0]);
}
