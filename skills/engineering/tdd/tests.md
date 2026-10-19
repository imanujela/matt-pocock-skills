# Good and bad tests

## Good tests

Test through the real interface, not through a mock of an internal part.

```typescript
test("user can checkout with valid cart", async () => {
  const cart = createCart();
  cart.add(product);
  const result = await checkout(cart, paymentMethod);
  expect(result.status).toBe("confirmed");
});
```

A good test:

- Names behaviour callers care about
- Uses the public interface only
- Survives an internal refactor
- Describes what, not how
- Makes one logical assertion

## Bad tests

An implementation-detail test is coupled to internal structure.

```typescript
test("checkout calls the payment collaborator", async () => {
  const mockPayment = jest.mock(paymentCollaborator);
  await checkout(cart, payment);
  expect(mockPayment.process).toHaveBeenCalledWith(cart.total);
});
```

Red flags, each paired with the positive target (assert through the interface):

- Mocking an internal collaborator
- Testing a private method
- Asserting on call counts or order
- A test that breaks on a refactor when behaviour has not changed
- A name that describes how, not what
- Verifying through a side channel instead of the interface

```typescript
test("createUser saves to the database", async () => {
  await createUser({ name: "Alice" });
  const row = await db.query("SELECT * FROM users WHERE name = ?", ["Alice"]);
  expect(row).toBeDefined();
});

test("createUser makes the user retrievable", async () => {
  const user = await createUser({ name: "Alice" });
  const retrieved = await getUser(user.id);
  expect(retrieved.name).toBe("Alice");
});
```

The first reaches past the interface. The second crosses the same seam a caller uses.

## Tautological tests

A tautological test recomputes the expected value the way the code does, so it passes by construction.

```typescript
test("calculateTotal sums line items", () => {
  const items = [{ price: 10 }, { price: 5 }];
  const expected = items.reduce((sum, i) => sum + i.price, 0);
  expect(calculateTotal(items)).toBe(expected);
});

test("calculateTotal sums line items", () => {
  expect(calculateTotal([{ price: 10 }, { price: 5 }])).toBe(15);
});
```

The expected value comes from an independent source: a known literal, a worked example, the spec.
