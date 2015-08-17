//
//  OrientationViewController.m
//  GearBrakeDemo
//
//  Created by Matthew Dobson on 8/13/15.
//  Copyright (c) 2015 Matthew Dobson. All rights reserved.
//

#import "OrientationViewController.h"
#import <ZettaKit/ZIKStreamEntry.h>
#import "monkeytex.h"
#import <OpenGLES/ES2/glext.h>

#define BUFFER_OFFSET(i) ((char*)NULL + (i))

GLfloat gCubeVertexData[216] =
{
    //x     y      z              nx     ny     nz
    1.0f, -1.0f, -1.0f,         1.0f,  0.0f,  0.0f,
    1.0f,  1.0f, -1.0f,         1.0f,  0.0f,  0.0f,
    1.0f, -1.0f,  1.0f,         1.0f,  0.0f,  0.0f,
    1.0f, -1.0f,  1.0f,         1.0f,  0.0f,  0.0f,
    1.0f,  1.0f,  1.0f,         1.0f,  0.0f,  0.0f,
    1.0f,  1.0f, -1.0f,         1.0f,  0.0f,  0.0f,
    
    1.0f,  1.0f, -1.0f,         0.0f,  1.0f,  0.0f,
    -1.0f,  1.0f, -1.0f,         0.0f,  1.0f,  0.0f,
    1.0f,  1.0f,  1.0f,         0.0f,  1.0f,  0.0f,
    1.0f,  1.0f,  1.0f,         0.0f,  1.0f,  0.0f,
    -1.0f,  1.0f, -1.0f,         0.0f,  1.0f,  0.0f,
    -1.0f,  1.0f,  1.0f,         0.0f,  1.0f,  0.0f,
    
    -1.0f,  1.0f, -1.0f,        -1.0f,  0.0f,  0.0f,
    -1.0f, -1.0f, -1.0f,        -1.0f,  0.0f,  0.0f,
    -1.0f,  1.0f,  1.0f,        -1.0f,  0.0f,  0.0f,
    -1.0f,  1.0f,  1.0f,        -1.0f,  0.0f,  0.0f,
    -1.0f, -1.0f, -1.0f,        -1.0f,  0.0f,  0.0f,
    -1.0f, -1.0f,  1.0f,        -1.0f,  0.0f,  0.0f,
    
    -1.0f, -1.0f, -1.0f,         0.0f, -1.0f,  0.0f,
    1.0f, -1.0f, -1.0f,         0.0f, -1.0f,  0.0f,
    -1.0f, -1.0f,  1.0f,         0.0f, -1.0f,  0.0f,
    -1.0f, -1.0f,  1.0f,         0.0f, -1.0f,  0.0f,
    1.0f, -1.0f, -1.0f,         0.0f, -1.0f,  0.0f,
    1.0f, -1.0f,  1.0f,         0.0f, -1.0f,  0.0f,
    
    1.0f,  1.0f,  1.0f,         0.0f,  0.0f,  1.0f,
    -1.0f,  1.0f,  1.0f,         0.0f,  0.0f,  1.0f,
    1.0f, -1.0f,  1.0f,         0.0f,  0.0f,  1.0f,
    1.0f, -1.0f,  1.0f,         0.0f,  0.0f,  1.0f,
    -1.0f,  1.0f,  1.0f,         0.0f,  0.0f,  1.0f,
    -1.0f, -1.0f,  1.0f,         0.0f,  0.0f,  1.0f,
    
    1.0f, -1.0f, -1.0f,         0.0f,  0.0f, -1.0f,
    -1.0f, -1.0f, -1.0f,         0.0f,  0.0f, -1.0f,
    1.0f,  1.0f, -1.0f,         0.0f,  0.0f, -1.0f,
    1.0f,  1.0f, -1.0f,         0.0f,  0.0f, -1.0f,
    -1.0f, -1.0f, -1.0f,         0.0f,  0.0f, -1.0f,
    -1.0f,  1.0f, -1.0f,         0.0f,  0.0f, -1.0f
};

@interface OrientationViewController () {
    GLuint vertexBuffer;
    GLuint vertexArray;
    float rotation;
    float heading;
    float pitch;
    float roll;
}

@property (strong, nonatomic) EAGLContext *context;
@property (strong, nonatomic) GLKBaseEffect *effect;
@property (strong, nonatomic) GLKTextureInfo *texture;

- (void) setupGL;
- (void) tearDownGL;

@end

@implementation OrientationViewController
@synthesize context;
@synthesize effect;

-(void) setupGL {
    [EAGLContext setCurrentContext:self.context];
    self.effect = [[GLKBaseEffect alloc] init];
    self.effect.light0.enabled = GL_TRUE;
    self.effect.light0.diffuseColor = GLKVector4Make(1.0f, 0.4f, 0.4f, 1.0f);
    self.effect.lightingType = GLKLightingTypePerPixel;
    
//    glEnable(GL_DEPTH_TEST);
//    glGenBuffers(1, &vertexBuffer);
//    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
//    glBufferData(GL_ARRAY_BUFFER, sizeof(gCubeVertexData), gCubeVertexData, GL_STATIC_DRAW);
//    
//    glEnableVertexAttribArray(GLKVertexAttribPosition);
//    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 24, BUFFER_OFFSET(0));
//    glEnableVertexAttribArray(GLKVertexAttribNormal);
//    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, 24, BUFFER_OFFSET(12));
    
    glEnable(GL_DEPTH_TEST);
    glGenVertexArraysOES(1, &vertexArray);
    glBindVertexArrayOES(vertexArray);
    
    glGenBuffers(1, &vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(MeshVertexData), MeshVertexData, GL_STATIC_DRAW);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(vertexDataTextured), 0);
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, sizeof(vertexDataTextured), (char *)12);
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(vertexDataTextured), (char *)24);
    
    glActiveTexture(GL_TEXTURE0);
    NSString *path = [[NSBundle mainBundle] pathForResource:@"monkey" ofType:@"png"];
    
    NSError *error;
    NSDictionary *options = @{GLKTextureLoaderOriginBottomLeft: [NSNumber numberWithBool:YES]};
    self.texture = [GLKTextureLoader textureWithContentsOfFile:path options:options error:&error];
    if (self.texture == nil) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }
    
    GLKEffectPropertyTexture *tex = [[GLKEffectPropertyTexture alloc] init];
    tex.enabled = YES;
    tex.envMode = GLKTextureEnvModeDecal;
    tex.name = self.texture.name;
    
    glBindVertexArrayOES(0);
}

-(void) tearDownGL {
    [EAGLContext setCurrentContext:self.context];
    glDeleteBuffers(1, &vertexBuffer);
    self.effect = nil;
}

-(void)viewDidLoad {
    self.euler = [self.orientation stream:@"euler"];
    heading = 0.0;
    pitch = 0.0;
    roll = 0.0;
    [self.euler.signal subscribeNext:^(ZIKStreamEntry *x) {
        NSLog(@"%@", x.data);
        NSString *stringHeading = (NSString *)x.data[@"heading"];
        NSString *stringPitch = (NSString *)x.data[@"pitch"];
        NSString *stringRoll = (NSString *)x.data[@"roll"];
        heading = [stringHeading floatValue];
        pitch = [stringPitch floatValue];
        roll = [stringRoll floatValue];
    }];
    [self.euler resume];
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    if (!self.context) {
        NSLog(@"Failed to create OpenGL context");
    }
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    [self setupGL];
}

- (void) update {
    float aspect = fabsf(self.view.bounds.size.width / self.view.bounds.size.height);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 0.1f, 100.0f);
    self.effect.transform.projectionMatrix = projectionMatrix;
    GLKMatrix4 modelMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -3.5f);
    modelMatrix = GLKMatrix4Rotate(modelMatrix, GLKMathDegreesToRadians(90), 1.0f, 0.0f, 0.0f);
    modelMatrix = GLKMatrix4RotateX(modelMatrix, GLKMathDegreesToRadians(heading));//heading in API response
    modelMatrix = GLKMatrix4RotateY(modelMatrix, GLKMathDegreesToRadians(pitch));//pitch in API Response
    modelMatrix = GLKMatrix4RotateZ(modelMatrix, GLKMathDegreesToRadians(roll));//roll in API Response
    //modelMatrix = GLKMatrix4Rotate(modelMatrix, rotation, 1.0f, 1.0f, 1.0f);
    self.effect.transform.modelviewMatrix = modelMatrix;
    //rotation += self.timeSinceLastUpdate * 1.0f;
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0.6f, 0.6f, 0.65f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glBindVertexArrayOES(vertexArray);
    [self.effect prepareToDraw];
    glDrawArrays(GL_TRIANGLES, 0, sizeof(MeshVertexData) / sizeof(vertexDataTextured));
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.paused = !self.paused;
}

- (void) dealloc {
    [self tearDownGL];
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
    self.context = nil;
}

-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        if (self.euler != nil) {
            [self.euler stop];
        }
    }
    [super viewWillDisappear:animated];
}

@end
