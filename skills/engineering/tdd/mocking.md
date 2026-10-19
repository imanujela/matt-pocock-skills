# When to mock

Mock at an external seam only. The interface of your own module stays real.

Mock:

- An external adapter (payment, email, and the like)
- A database, sometimes. Prefer a test database.
- Time and randomness
- The filesystem, sometimes

Your own modules stay real. Internal collaborators stay real. Anything you control stays real. Mocking past the seam is a hard guardrail: the positive target is a test that crosses the same seam a caller uses.

## Designing the adapter

At an external seam, design an interface that is easy to substitute.

**1. Accept the dependency.**

Pass the external adapter in. Constructing it inside the function hides the seam.

```typescript
function processPayment(order, paymentClient) {
  return paymentClient.charge(order.total);
}

function processPayment(order) {
  const client = new StripeClient(process.env.STRIPE_KEY);
  return client.charge(order.total);
}
```

The first is the positive target. The second makes the test reach past the interface.

**2. Prefer a specific interface over one generic fetcher.**

One function per external operation. A single generic function forces conditional logic inside the mock.

```typescript
const payments = {
  getUser: (id) => fetch(`/users/${id}`),
  getOrders: (userId) => fetch(`/users/${userId}/orders`),
  createOrder: (data) => fetch("/orders", { method: "POST", body: data }),
};

const payments = {
  fetch: (endpoint, options) => fetch(endpoint, options),
};
```

The specific interface means each substitute returns one shape, setup has no conditional logic, and a test shows which operations it exercises.

One adapter means a hypothetical seam. Two adapters (production and test) means a real one.
