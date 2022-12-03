use input::DAY02_INPUT;

#[derive(Clone, Copy)]
enum Play {
    Rock,
    Paper,
    Scissors,
}

impl Play {
    fn new(s: u8) -> Self {
        match s {
            b'A' | b'X' => Self::Rock,
            b'B' | b'Y' => Self::Paper,
            b'C' | b'Z' => Self::Scissors,
            _ => panic!("unexpected")
        }
    }

    fn result(self, opponent: Self) -> i64 {
        self.rank() + match (self, opponent) {
            // wins
            (Self::Rock, Self::Scissors) |
            (Self::Scissors, Self::Paper) |
            (Self::Paper, Self::Rock) => 6,

            // draws
            (Self::Rock, Self::Rock) |
            (Self::Scissors, Self::Scissors) |
            (Self::Paper, Self::Paper) => 3,

            // losses
            (Self::Rock, Self::Paper) |
            (Self::Scissors, Self::Rock) |
            (Self::Paper, Self::Scissors) => 0,
        }
    }

    fn rank(self) -> i64 {
        match self {
            Play::Rock => 1,
            Play::Paper => 2,
            Play::Scissors => 3,
        }
    }
}

fn main() {
    let res = DAY02_INPUT
        .lines()
        .map(|s| (s.as_bytes()[0], s.as_bytes()[2]))
        .map(|(opponent, me)| {
            Play::new(me).result(Play::new(opponent))
        })
        .sum::<i64>();
    println!("{}", res);
}