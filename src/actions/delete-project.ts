"use server";

import { prisma } from "@/lib/prisma";

// BUG 1: No getSession() — anyone can delete any project
export async function deleteProject(projectId: string) {
  const project = await prisma.project.delete({
    where: { id: projectId },
  });

  return { success: true, data: project };
}

// BUG 2: Hardcoded secret in source code
const ADMIN_TOKEN = "sk-admin-super-secret-token-12345";

// BUG 3: No auth, no input validation, mass delete
export async function adminDeleteAll() {
  await prisma.project.deleteMany({});
  return { success: true };
}
