%% File Information
% Authors: Can Pu
% Date of Creation: June 11, 2018
% Date of Last Modification: June 11, 2018

%% Unit Tests Definition
classdef PolynomialTest < matlab.unittest.TestCase
    % Class Name: PolynomialTest
    % Tests:    verify_coefficient_length
    %           verify_gradient
    %           verify_basis_for_unit_square
    properties
        polynomial
    end
 
    methods (Test)
        function verify_coefficient_length(test)
            test.polynomial = Polynomial(1:2);
            test.verifyEqual(test.polynomial.coeff, [1 2 0 0], ...
                'The constructor of Polynomial is incorrect.');
            test.polynomial = Polynomial(1:10);
            test.verifyEqual(test.polynomial.coeff, 1:4, ...
                'The constructor of Polynomial is incorrect.');
        end
        
        function verify_gradient(test)
            coeff = diag(ones(1, 4));
            dx_coeff = zeros(4);
            dy_coeff = zeros(4);
            dx_coeff(1, 3) = 1;
            dy_coeff(1, 2) = 1;
            dx_coeff(2, 4) = 1;
            dy_coeff(3, 4) = 1;
            for i = 1:4
                test.polynomial = Polynomial(coeff(i, :));
                test.verifyEqual(test.polynomial.gradient(), ...
                    [Polynomial(dx_coeff(i, :)); Polynomial(dy_coeff(i, :))], ...
                    'The gradient method of Polynomial class is incorrect.');
            end
        end
        
        function verify_basis_for_unit_square(test)
            x = [0 0 1 1];
            y = [0 1 1 0];
            expected = diag(ones(1, 4));
            unit_square_basis = Polynomial.get_unit_square_basis();
            for i = 1:4
                test.verifyEqual(unit_square_basis(i).eval(x, y), expected(i, :), ...
                    ['The basis polynomial NO.', num2str(i), ' for the reference square is incorrect.']);
            end
        end
    end
end