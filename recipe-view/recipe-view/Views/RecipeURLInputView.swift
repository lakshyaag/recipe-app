import SwiftUI

struct RecipeURLInputView: View {
    @ObservedObject var viewModel: RecipeViewModel
    @FocusState private var isURLFieldFocused: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            // URL Input Field with Paste Button
            HStack(spacing: 12) {
                // URL Input
                HStack {
                    Image(systemName: "link")
                        .foregroundColor(AppColors.contentSecondary)
                    
                    TextField("Enter recipe URL", text: $viewModel.url)
                        .textFieldStyle(.plain)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .focused($isURLFieldFocused)
                    
                    if !viewModel.url.isEmpty {
                        Button(action: { viewModel.resetForm() }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(AppColors.contentSecondary)
                        }
                    }
                }
                .padding()
                .background(AppColors.backgroundSecondary)
                .cornerRadius(12)
                
                // Paste Button
                Button(action: handlePaste) {
                    Image(systemName: "doc.on.clipboard")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(AppColors.backgroundPrimary)
                        .frame(width: 44, height: 44)
                        .background(AppColors.brandBase)
                        .clipShape(Circle())
                }
            }
            
            // Fetch Button
            Button(action: { viewModel.fetchRecipe() }) {
                HStack {
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Image(systemName: "arrow.right")
                    }
                    Text(viewModel.isLoading ? "Fetching..." : "Get Recipe")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(AppColors.brandBase)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            .disabled(viewModel.url.isEmpty || viewModel.isLoading)
            .opacity(viewModel.url.isEmpty ? 0.6 : 1.0)
        }
        .alert("Error", isPresented: $viewModel.showError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.error?.localizedDescription ?? "Unknown error occurred")
        }
    }
    
    private func handlePaste() {
        // Dismiss keyboard
        isURLFieldFocused = false
        
        // Get clipboard content
        if let string = UIPasteboard.general.string {
            viewModel.url = string
        }
    }
}

// Preview
struct RecipeURLInputView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeURLInputView(viewModel: RecipeViewModel())
            .padding()
    }
} 