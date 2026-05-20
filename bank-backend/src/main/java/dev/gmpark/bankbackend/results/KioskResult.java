package dev.gmpark.bankbackend.results;

public enum KioskResult implements Result{
    SUCCESS,
    FAILURE,
    FAILURE_EXISTING_RESIDENT_NUMBER,
    FAILURE_NOT_AGREED
}
