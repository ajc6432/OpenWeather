import Foundation

extension Date {
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }

    var timeString: String {
        let df = DateFormatter()
        df.dateFormat = "h:mm"
        return df.string(from: self)
    }

    var ampmTimeString: String {
        let df = DateFormatter()
        df.dateFormat = "h:mm a"
        return df.string(from: self)
    }

    var weekdayString: String {
        let df = DateFormatter()
        df.dateFormat = "EEEE"
        return df.string(from: self)
    }

    var shorthandWeekdayString: String {
        let df = DateFormatter()
        df.dateFormat = "E"
        return df.string(from: self)
    }

    var shortHandString: String {
        let df = DateFormatter()
        df.dateFormat = "MMM d"
        return df.string(from: self)
    }

    var shortHandFullString: String {
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        return df.string(from: self)
    }

    var fullString: String {
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMMMM d, yyyy"
        return df.string(from: self)
    }

}
