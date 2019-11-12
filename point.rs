struct Point<T> {
    x: T,
    y: T,
}

use std::ops::Add;

impl<T: Add<Output = T> + Copy> Point<T> {
    fn new(x: T, y: T) -> Self {
        Point { x, y }
    }
    
    fn sum(&self) -> T {
        self.x + self.y
    }
}


fn main() {
    let points1: [Point::<i32>; 2] = [
        Point::new(1, 2),
        Point::new(1, 8),
    ];
    
    let points2: [Point::<f32>; 2] = [
        Point::new(1.0, 2.0),
        Point::new(1.0, 8.0),
    ];
    
    for point in points1.iter() {
        println!("|{}|", point.sum());
    }
    
    for point in points2.iter() {
        println!("|{}|", point.sum());
    }
}

