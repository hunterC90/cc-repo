import numpy as np

def create_unique_identifiers_vectorized(x_list, y_list, z_list):
    X, Y, Z = np.meshgrid(x_list, y_list, z_list, indexing='ij')
    identifiers = np.core.defchararray.add(X.astype(str), "_")
    identifiers = np.core.defchararray.add(identifiers, Y.astype(str))
    identifiers = np.core.defchararray.add(identifiers, "_")
    identifiers = np.core.defchararray.add(identifiers, Z.astype(str))
    return identifiers.flatten()

# Example usage
x_list = np.array([1, 2, 3])  # Example X coordinates
y_list = np.array([4, 5])     # Example Y coordinates
z_list = np.array([6, 7])     # Example Z coordinates

unique_identifiers = create_unique_identifiers_vectorized(x_list, y_list, z_list)
print(unique_identifiers)