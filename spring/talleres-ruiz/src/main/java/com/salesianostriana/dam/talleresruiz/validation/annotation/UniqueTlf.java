package com.salesianostriana.dam.talleresruiz.validation.annotation;

import com.salesianostriana.dam.talleresruiz.validation.validator.UniqueTlfValidator;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.*;

@Documented
@Target({ElementType.METHOD, ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = UniqueTlfValidator.class)
public @interface UniqueTlf {

    String message() default "El teléfono ya existe";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

}
