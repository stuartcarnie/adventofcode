use std::collections::hash_map::{RandomState};
use std::collections::HashSet;
use itertools::Itertools;
use input::DAY03_INPUT;

fn main() {
    let res = DAY03_INPUT
        .lines()
        // Break the lines into groups of 3
        .chunks(3)
        .into_iter()
        .map(|chunks| {
            // convert the chunks into a Vec<&[u8]>
            Vec::from_iter(chunks.map(&str::as_bytes))
        })
        .map(|vecs| -> Vec<HashSet<&u8, RandomState>> {
            // convert the Vec<&[u8]> to a Vec<HashSet<&u8>> to
            // reduce slices to their unique sets of values
            vecs.into_iter().map(HashSet::from_iter).collect()
        })
        .map(|sets| {
            // Progressively intersect all the sets, which should leave one (or more)
            // values that are common among all the sets
            let mut s = sets[0].clone();
            for o in &sets.as_slice()[1..] {
                s = HashSet::from_iter(s.intersection(o).cloned());
            }

            // Obtain the first value, which is common for all sets
            let res = s.into_iter().take(1).collect::<Vec<_>>()[0];
            (match res {
                b'A'..=b'Z' => res - b'A' + 27,
                b'a'..=b'z' => res - b'a' + 1,
                _ => panic!("unexpected")
            }) as i32
        })
        .sum::<i32>();

    println!("{:?}", res);
}