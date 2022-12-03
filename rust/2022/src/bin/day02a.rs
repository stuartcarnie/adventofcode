use input::DAY02_INPUT;

#[derive(Clone, Copy)]
enum Play {
    Rock,
    Paper,
    Scissors,
}

enum Result {
    Loss,
    Draw,
    Win,
}

impl Result {
    fn new(s: u8) -> Self {
        match s {
            b'X' => Self::Loss,
            b'Y' => Self::Draw,
            b'Z' => Self::Win,
            _ => panic!("unexpected")
        }
    }
}

impl Play {
    fn new_round(opponent: u8, result: Result) -> (Self, Self) {
        let opponent = match opponent {
            b'A' => Self::Rock,
            b'B' => Self::Paper,
            b'C' => Self::Scissors,
            _ => panic!("unexpected")
        };

        (opponent, match (opponent, result) {
            (Self::Rock, Result::Loss) => Self::Scissors,
            (Self::Rock, Result::Draw) => Self::Rock,
            (Self::Rock, Result::Win) => Self::Paper,

            (Self::Paper, Result::Loss) => Self::Rock,
            (Self::Paper, Result::Draw) => Self::Paper,
            (Self::Paper, Result::Win) => Self::Scissors,

            (Self::Scissors, Result::Loss) => Self::Paper,
            (Self::Scissors, Result::Draw) => Self::Scissors,
            (Self::Scissors, Result::Win) => Self::Rock,
        })
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
        .map(|(opponent, result)| {
            let (opponent, me) = Play::new_round(opponent, Result::new(result));
            me.result(opponent)
        })
        .sum::<i64>();
    println!("{}", res);
}