use std::collections::hash_map::{RandomState};
use std::collections::HashSet;
use input::DAY03_INPUT;

fn main() {
    let res = DAY03_INPUT
        .lines()
        .map(|s| vec![&s.as_bytes()[0..s.len() / 2], &s.as_bytes()[s.len() / 2..]])
        .map(|vecs| -> Vec<HashSet<&u8, RandomState>> {
            vecs.into_iter().map(HashSet::from_iter).collect()
        })
        .map(|sets| {
            let mut s = sets[0].clone();
            for o in &sets.as_slice()[1..] {
                s = HashSet::from_iter(s.intersection(o).cloned());
            }
            let res = s.into_iter().take(1).cloned().collect::<Vec<u8>>()[0];
            (match res {
                b'A'..=b'Z' => res - b'A' + 27,
                b'a'..=b'z' => res - b'a' + 1,
                _ => panic!("unexpected")
            }) as i32
        })
        .sum::<i32>();

    println!("{:?}", res);
}