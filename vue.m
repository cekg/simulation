dx = 0.02;
sigma = 0.1;
a = 1;
L = 2;
k = 4;
n_t =50;
T = n_t * sigma * dx;
dt = sigma * dx;
x = 0:dx:L;
t = 0:dt:T
% Coefficients
b0 = 0.5 * (1 - sigma) * (2 - sigma);
b1 = sigma * (2 - sigma);
b2 = 0.5 * sigma * (sigma - 1);

nx = length(x);
nt = length(t);

% conditions initiales
u0 = sin(2 * k * pi * x);

% Initial matrix solution
u = zeros(nt, nx);
u(1,:) = u0;

% Conditions aux bords avec solution exacte
for n = 1:nt
    u(n,1) = sin(2 * k * pi * (0 - t(n)));  % u(0,t)
    u(n,end) = sin(2 * k * pi * (L - t(n)));  % u(L,t)
end

% discrétisation
for n = 1:nt-1
  for i = 2:nx-1
    u(n+1,i) = (b0 - b2) * u(n,i) + (b1 + 2 * b2) * u(n,i-1);
  end
end

% Solution exacte
u_exact = zeros(nt, nx);
for n = 1:nt
  u_exact(n,:) = sin(2 * k * pi * (x - t(n)));
end

u_exact(1,1)
% Plot solutions
figure;
subplot(2,2,1);
plot(x, u(end,:));
title('Solution numerique');
xlabel('x');
ylabel('u');

subplot(2,2,2);
plot(x, u_exact(end,:),'r');
title('Solution exacte');
xlabel('x');
ylabel('u');

subplot(2,2,3);

plot(x, u(end,:), 'b-', 'DisplayName', 'Solution numerique');
hold on;
plot(x, u_exact(end,:), 'r-', 'DisplayName', 'Solution exacte');
title('Solution numerique et exacte');
xlabel('x');
ylabel('u');
legend('solution numerique','solution exacte');

%Erreur de diffusion

phi = linspace(0,pi, 100);
e_d = sqrt((b0 + b1 .* cos(phi) + b2 .* cos(2 * phi)).^2 + ((-b1 .* sin(phi) - b2 .* sin(2 * phi)).^2));

% Plot de l'erreur de diffusion
figure;
plot(phi,e_d);
title('Erreur de diffusion en fonction de phi');
xlabel('phi');
ylabel('e_d');