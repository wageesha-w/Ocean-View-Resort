package com.OceanViewResort.BeanTest;

import org.junit.platform.suite.api.SelectClasses;
import org.junit.platform.suite.api.Suite;

@Suite
@SelectClasses({ AdminBeanTest.class, ReservationBeanTest.class, RoomBeanTest.class, RoomTypeBeanTest.class })
public class AllBeanTests {

}
