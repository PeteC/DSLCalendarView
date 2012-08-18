
# DSLCalendarView

DSLCalendar view is an iOS control that displays a calendar similar to the system calendar. It allows the user to select a single date or a date range.

![](http://github.com/PeteC/DSLCalendarView/raw/images/Screenshot.png)

----

## DSLCalendarMonthSelectorView

DSLCalendarMonthSelectorView is the view displayed above the current month. It contains a label showing the current month and year, labels for the days of the week and buttons to allow the user to navigate to the previous or next month.

## DSLCalendarMonthView

DSLCalendarMonthView contains a grid of DSLCalendarDayViews for a specific month.

## DSLCalendarDayView

DSLCalendarDayView is the view that represents a single day in a month view

----

## Appearance Customisation

To customise the appearance of the calendar, you should subclass DSLCalendarView and optionally DSLCalendarMonthSelectorView, DSLCalendarMonthView and DSLCalendarDayView. In your DSLCalendarView subclass, you should override the following methods to specify which classes the calendar view should use:

```objective-c
+ (Class)monthSelectorViewClass;
+ (Class)monthViewClass;
+ (Class)dayViewClass;
```

This project is still a work in progress so while the appearnce customisation should work, it's not been fully tested yet. I will adding a customisation to the example project to both test customisation and to show a working example.


----

## ARC

This project uses ARC.

---

## License
Copyright © 2012 Pete Callaway. All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

* Neither the name of the author nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.