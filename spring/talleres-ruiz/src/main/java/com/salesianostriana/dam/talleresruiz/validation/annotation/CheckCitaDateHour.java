package com.salesianostriana.dam.talleresruiz.validation.annotation;

import com.salesianostriana.dam.talleresruiz.validation.validator.CheckCitaDateHourValidator;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.*;

@Documented
@Target({ElementType.METHOD, ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = CheckCitaDateHourValidator.class)
public @interface CheckCitaDateHour {

    String message() default "El horario es de LUNES a VIERNES, de 7:30 a 15:30";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

}
