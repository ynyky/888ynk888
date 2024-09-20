package com.softwaremill

import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers

class DummySpec extends AnyFlatSpec with Matchers {

  it should "add two numbers" in {
    // given
    val a = 2
    val b = 2

    // when
    val result = a + b

    // then
    result shouldBe 4
  }

  it should "know the answer to life, the universe and everything" in {
    // when
    val answer = 42

    // then
    answer shouldBe 42
  }
}
