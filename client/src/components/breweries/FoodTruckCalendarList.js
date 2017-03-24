import React, {PropTypes} from 'react';

const FoodTruckCalendarList = ({foodTruckCalendars}) => {
  return (
    <div>
      <h3>Food Truck Calendars</h3>
      <ul>
        {foodTruckCalendars.map(foodTruckCalendar =>
            <li key={foodTruckCalendar.id}>{foodTruckCalendar.name}</li>
          )}
      </ul>
    </div>
  );
};

FoodTruckCalendarList.propTypes = {
  foodTruckCalendars: PropTypes.array.isRequired
};

export default FoodTruckCalendarList;