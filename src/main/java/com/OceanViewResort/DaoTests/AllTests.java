package com.OceanViewResort.DaoTests;

import org.junit.platform.suite.api.SelectClasses;
import org.junit.platform.suite.api.Suite;

@Suite
@SelectClasses({ AdminDAOTest.class, ReservationDAOTest.class, RoomDAOTest.class, RoomTypeDAOTest.class })
public class AllTests {

}
