package com.salesianostriana.dam.talleresruiz.validation.annotation;

import com.salesianostriana.dam.talleresruiz.validation.validator.PasswordSeguraValidator;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target({ElementType.METHOD, ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = PasswordSeguraValidator.class)
public @interface PasswordSegura {

    String message() default "La contraseña no reúne los requisitos establecidos";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

    int min() default 6;

    int max() default 12;

    boolean hasUpper() default true;

    boolean hasLower() default true;

    boolean hasAlpha() default true;

    boolean hasNumber() default true;

    boolean hasSpecial() default true;

}
