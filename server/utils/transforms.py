import numpy as np
from typing import Tuple, Optional

class Transform3D:
    @staticmethod
    def create_rotation_matrix(angles: Tuple[float, float, float]) -> np.ndarray:
        """Create 3D rotation matrix from Euler angles (XYZ order)."""
        x, y, z = angles
        Rx = np.array([
            [1, 0, 0],
            [0, np.cos(x), -np.sin(x)],
            [0, np.sin(x), np.cos(x)]
        ])
        
        Ry = np.array([
            [np.cos(y), 0, np.sin(y)],
            [0, 1, 0],
            [-np.sin(y), 0, np.cos(y)]
        ])
        
        Rz = np.array([
            [np.cos(z), -np.sin(z), 0],
            [np.sin(z), np.cos(z), 0],
            [0, 0, 1]
        ])
        
        return Rz @ Ry @ Rx

    @staticmethod
    def create_view_matrix(eye: np.ndarray,
                          target: np.ndarray,
                          up: np.ndarray) -> np.ndarray:
        """Create view matrix from camera parameters."""
        forward = target - eye
        forward = forward / np.linalg.norm(forward)
        
        right = np.cross(forward, up)
        right = right / np.linalg.norm(right)
        
        up = np.cross(right, forward)
        
        view_matrix = np.eye(4)
        view_matrix[:3, 0] = right
        view_matrix[:3, 1] = up
        view_matrix[:3, 2] = -forward
        view_matrix[:3, 3] = -eye
        
        return view_matrix

    @staticmethod
    def create_perspective_matrix(fov: float,
                                aspect: float,
                                near: float,
                                far: float) -> np.ndarray:
        """Create perspective projection matrix."""
        f = 1.0 / np.tan(fov / 2)
        
        projection = np.zeros((4, 4))
        projection[0, 0] = f / aspect
        projection[1, 1] = f
        projection[2, 2] = (far + near) / (near - far)
        projection[2, 3] = 2 * far * near / (near - far)
        projection[3, 2] = -1
        
        return projection